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

- (bool) authenticated {
  return _authenticated;
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
}

@end
