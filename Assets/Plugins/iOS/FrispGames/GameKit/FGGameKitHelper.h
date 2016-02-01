#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
 
@interface FGGameKitHelper : NSObject

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

extern NSString *const PresentAuthenticationViewController;
 
+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
- (bool)authenticated;

@end