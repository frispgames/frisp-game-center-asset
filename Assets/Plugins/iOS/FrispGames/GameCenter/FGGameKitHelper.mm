#import "FGGameKitHelper.h"

@implementation FGGameKitHelper

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";

bool _authenticated;

- (id)init {
  self = [super init];
  return self;
}

+ (instancetype)sharedGameKitHelper {
  static FGGameKitHelper *sharedGameKitHelper;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedGameKitHelper = [[FGGameKitHelper alloc] init];
  });
  return sharedGameKitHelper;
}

- (void)authenticateLocalPlayer {
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  if(localPlayer.authenticated == NO) {
    [localPlayer setAuthenticateHandler:^(UIViewController * authViewController, NSError * error) {
      if(authViewController != nil) {
         UIViewController *rootViewController = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
        [rootViewController presentViewController:authViewController animated:YES completion: nil];
      } else if (error != nil) {
        NSLog(@"Problem authenticating");
      }
    }];
  } else {
    NSLog(@"Already authenticated");
  }
}

- (void)reportScore:(int64_t)score leaderboardId:(NSString*)leaderboardId {
  GKScore* scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardId];
  
  scoreReporter.value = score;
  scoreReporter.context = 0;
  
  [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError * error){
    if(error != nil) {
      NSLog(@"Unable to report score");
    }
  }];
}

- (void)reportAchievement:(NSString*)achievementId percentComplete:(double)percentComplete {
  GKAchievement* achievement = [[GKAchievement alloc] initWithIdentifier:achievementId];
  
  if(achievement && achievement.percentComplete != 100.0) {
    achievement.percentComplete = percentComplete;
    achievement.showsCompletionBanner = YES;
    
    [GKAchievement reportAchievements:@[achievement] withCompletionHandler:^(NSError * _Nullable error) {
      if(error != nil) {
        NSLog(@"Error while reporting achievement: %@", error.description);
      }
    }];
  }
}

- (void)showLeaderboard:(NSString*)leaderboardId {
  GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
  if (gameCenterController != NULL)
  {
    gameCenterController.gameCenterDelegate = self;
    gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
    gameCenterController.leaderboardIdentifier = leaderboardId;
    [UnityGetGLViewController() presentViewController:gameCenterController animated:YES completion:nil];
  }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)viewController
{
  [UnityGetGLViewController() dismissViewControllerAnimated:YES completion:nil];
}

- (bool) authenticated {
  return [GKLocalPlayer localPlayer].authenticated;
}

static FGGameKitHelper *gamekitHelper = nil;

extern "C" {
  void _Initialize() {
    if (gamekitHelper == nil) {
      gamekitHelper = [FGGameKitHelper sharedGameKitHelper];
    }
  }
  
  void _Authenticate() {
    [gamekitHelper authenticateLocalPlayer];
  }
  
  bool _Authenticated() {
    return [gamekitHelper authenticated];
  }
  
  void _ReportScore(int64_t score, const char* leaderboardId) {
    NSString* _leaderboardId = [[NSString alloc] initWithUTF8String:leaderboardId];
    [gamekitHelper reportScore:score leaderboardId:_leaderboardId];
  }
  
  void _ReportAchievement(const char* achievementId, float percentComplete)
  {
    NSString* _achievementId = [[NSString alloc] initWithUTF8String:achievementId];
    [gamekitHelper reportAchievement:_achievementId percentComplete:(double)percentComplete];
  }
  
  void _ShowLeaderboard(const char* leaderboardId)
  {
    NSString* _leaderboardId = [[NSString alloc] initWithUTF8String:leaderboardId];
    [gamekitHelper showLeaderboard:_leaderboardId];
  }
}

@end
