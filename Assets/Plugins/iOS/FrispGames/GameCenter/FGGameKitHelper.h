#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
 
@interface FGGameKitHelper : NSObject <GKGameCenterControllerDelegate> {}

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

extern NSString *const PresentAuthenticationViewController;
 
+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
- (bool)authenticated;
- (void)reportAchievement:(NSString*)achievementId percentComplete:(double)percentComplete;
- (void)showLeaderboard:(NSString*)leaderboardId;
- (void)reportScore:(int64_t)score leaderboardId:(NSString*)leaderboardId;

@end