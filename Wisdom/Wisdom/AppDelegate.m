//
//  AppDelegate.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "AppDelegate.h"
#import "StoryboardManager.h"
#import "OnboardingViewController.h"
#import "MainContainerViewController.h"
#import <Parse/Parse.h>
#import "QuotesViewController.h"
#import "PushNotificationViewController.h"
#import "InviteFriendViewController.h"
#import "EmailViewController.h"
#import "ParseLocalStoreManager.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#define IS_iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0


@interface AppDelegate ()
@property (nonatomic, strong) QuotesViewController *quotesViewController;
@property (nonatomic, strong) PushNotificationViewController *pushNotificaitonViewController;
@property (nonatomic, strong) InviteFriendViewController *inviteFriendViewController;
@property (nonatomic, strong) EmailViewController *emailViewController;

@property (nonatomic, strong) NSTimer *pushNotificationTimer;
@property (nonatomic, strong) NSTimer *inviteFriendTimer;
@end

@implementation AppDelegate

- (void)checkToShowQuotesView
{
    if ([GeneralSettings showQuotesScreen]) {
        self.quotesViewController = [StoryboardManager quotesViewController];
        self.quotesViewController.view.frame = self.window.frame;
        [self.window.rootViewController.view addSubview:self.quotesViewController.view];
    }
}

- (void)hideQuotesScreen
{
    [self.quotesViewController.view removeFromSuperview];
    self.quotesViewController = nil;
}

- (void)showPushNotificationView
{
    self.pushNotificaitonViewController = [StoryboardManager pushNotificationViewController];
    self.pushNotificaitonViewController.view.frame = self.window.frame;
    [self.window.rootViewController.view addSubview:self.pushNotificaitonViewController.view];
}

- (void)showInviteFriendScreen
{
    self.inviteFriendViewController = [StoryboardManager inviteFriendViewController];
    self.inviteFriendViewController.view.frame = self.window.frame;
    [self.window.rootViewController.view addSubview:self.inviteFriendViewController.view];
}

- (void)hideInviteFriendScreen
{
    [UIView animateWithDuration:0.3 animations:^{
        self.inviteFriendViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.inviteFriendViewController.view removeFromSuperview];
        self.inviteFriendViewController = nil;
    }];
}

- (void)showEmailFieldScreen
{
    self.emailViewController = [StoryboardManager emailViewController];
    self.emailViewController.view.frame = self.window.frame;
    [self.window.rootViewController.view addSubview:self.emailViewController.view];
}

#pragma mark - push notification timer methods
- (void)startPushNotificationTimer
{
    [self stopPushNotificationTimer];
    self.pushNotificationTimer = [NSTimer scheduledTimerWithTimeInterval:90.0 target:self selector:@selector(pushNotificationTimerFired) userInfo:nil repeats:NO];
}

- (void)pushNotificationTimerFired
{
    [self stopPushNotificationTimer];
    [self showPushNotificationView];
}

- (void)stopPushNotificationTimer
{
    [self.pushNotificationTimer invalidate];
    self.pushNotificationTimer = nil;
}

#pragma mark - invite friend view
- (void)startInviteFriendTimer
{
    [self stopPushNotificationTimer];
    self.inviteFriendTimer = [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(inviteFriendTimerFired) userInfo:nil repeats:NO];
}

- (void)inviteFriendTimerFired
{
    [self stopInviteFriendTimer];
    [self showInviteFriendScreen];
}

- (void)stopInviteFriendTimer
{
    [self.inviteFriendTimer invalidate];
    self.inviteFriendTimer = nil;
}

#pragma mark - app launch methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"FqdCInc5wYV5Hk2kDVF0mIF2l5WvqhIFyXTaUhw9" clientKey:@"78xx8sl0wFaqK97BWnqev2C4I3LPv9XpEhIv76Vv"];
    [Fabric with:@[[Crashlytics class]]];

    if ([GeneralSettings onboardingCompleted]) {
        self.window.rootViewController = [StoryboardManager mainContainerViewController];
    } else {
        self.window.rootViewController = [StoryboardManager onboardingViewController];
    }

    [self checkToShowQuotesView];

    if ([GeneralSettings showPushNotificationView]) {
        [self startPushNotificationTimer];
    }

    if (![GeneralSettings appLaunchDate]) {
        [GeneralSettings setAppLaunchDate];
    }

    if ([GeneralSettings inviteFriendScreenNeedsToShow]) {
        [self startInviteFriendTimer];
        [GeneralSettings resetInviteFriendShowCount];
    } else {
        [GeneralSettings increaseInviteFriendShowCount];
    }

    [self createAnonymousUser];

    [ParseLocalStoreManager sharedManager];

    return YES;
}

- (void)createAnonymousUser
{
    NSString *userID = [self uuid];

    if (![PFUser currentUser]) {
        // we don't have a user yet

        PFUser *user = [PFUser user];
        user.username = userID;
        user.password = [self randomizeString:userID];

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                // sign up successful
            } else {
                NSLog(@"Error occured at signup: %@", error.localizedDescription);
            }
        }];

//        [PFAnonymousUtils logInWithBlock:^(PFUser * _Nullable user, NSError * _Nullable error) {
//            if (error) {
//                // error occured
//            } else {
//                NSLog(@"Current user: %@", user);
//            }
//        }];
    } else {
        // user already exists
        NSLog(@"current user: %@", [PFUser currentUser]);
    }
}

- (NSString *)randomizeString:(NSString *)str
{
    NSMutableString *input = [str mutableCopy];
    NSMutableString *output = [NSMutableString string];

    NSUInteger len = input.length;

    for (NSUInteger i = 0; i < len; i++) {
        NSInteger index = arc4random_uniform((unsigned int)input.length);
        [output appendFormat:@"%C", [input characterAtIndex:index]];
        [input replaceCharactersInRange:NSMakeRange(index, 1) withString:@""];
    }

    return output;
}

- (NSString *)uuid
{
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor] UUIDString];

    currentDeviceId = [currentDeviceId stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return currentDeviceId;
}

#pragma mark - push notification
- (UIUserNotificationSettings*)userNotificationSettings
{
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    return settings;
}

- (void)askUserForPushNotifications
{
    // Register for Push Notitications
    UIUserNotificationSettings *settings = [self userNotificationSettings];

    UIApplication *application = [UIApplication sharedApplication];
    if (IS_iOS8) {
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRegisteredForNotifications" object:nil];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [GeneralSettings setShowPushNotificationAllowed:YES];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

@end
