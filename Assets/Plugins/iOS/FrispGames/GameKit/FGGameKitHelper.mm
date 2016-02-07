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

- (void)setAuthenticationViewController:(UIViewController *)authenticationViewController {
  if (authenticationViewController != nil) {
    authenticationViewController = authenticationViewController;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:PresentAuthenticationViewController
     object:self];
  }
}

- (void)showAuthenticationViewController
{
  FGGameKitHelper *gameKitHelper = [FGGameKitHelper sharedGameKitHelper];
  
  UIViewController *rootViewController = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
  
  [rootViewController presentViewController:
   gameKitHelper.authenticationViewController
                                       animated:YES
                                     completion:nil];
}

- (void)setLastError:(NSError *)error {
}

- (void) createEventTrigger {
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(showAuthenticationViewController)
   name:PresentAuthenticationViewController
   object:nil];
}

- (bool) authenticated {
  return _authenticated;
}

- (void)authenticateLocalPlayer {
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  [localPlayer setAuthenticateHandler:(^(UIViewController* viewController, NSError *error) {
    [self setLastError:error];
    
    if(viewController != nil) {
      [self setAuthenticationViewController:viewController];
    } else if([GKLocalPlayer localPlayer].isAuthenticated) {
      _authenticated = true;
    } else {
      _authenticated = false;
    }
  })];
}

- (void)reportScore:(int64_t)score leaderboardId:(NSString*)leaderboardId {
  GKScore* scoreReporter = [[GKScore alloc] initWithCategory:leaderboardId];
  
  scoreReporter.value = score;
  
  [scoreReporter reportScoreWithCompletionHandler:^(NSError *error){
    if(error != nil) {
      NSLog(@"Failed to report score");
    } else {
      NSLog(@"Succedded to report score");
    }
  }];
}

- (void)reportAchievement:(NSString*)achievementId percentComplete:(double)percentComplete {
  GKAchievement* achievement = [[GKAchievement alloc] initWithIdentifier:achievementId];
  
  achievement.showsCompletionBanner = YES;
  achievement.percentComplete = percentComplete;
  
  [achievement reportAchievementWithCompletionHandler:^(NSError *error){
    if(error != nil) {
      NSLog(@"Failed to report achievement");
    } else {
      NSLog(@"Succedded to report achievement");
    }
  }];
}

- (void)showLeaderboard:(NSString*)leaderboardId {
  GKLeaderboardViewController* leaderboardController = [[GKLeaderboardViewController alloc] init];
  if (leaderboardController != NULL)
  {
    leaderboardController.category = leaderboardId;
    leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
    leaderboardController.leaderboardDelegate = self;
    [UnityGetGLViewController() presentViewController:leaderboardController animated:YES completion:nil];
  }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
  [UnityGetGLViewController() dismissViewControllerAnimated:YES completion:nil];
}

static FGGameKitHelper *gamekitHelper = nil;

extern "C" {
  void _Initialize() {
    if (gamekitHelper == nil) {
      gamekitHelper = [FGGameKitHelper sharedGameKitHelper];
      [gamekitHelper createEventTrigger];
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
