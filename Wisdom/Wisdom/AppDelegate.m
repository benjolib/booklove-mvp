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

#define IS_iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0


@interface AppDelegate ()
@property (nonatomic, strong) QuotesViewController *quotesViewController;
@property (nonatomic, strong) PushNotificationViewController *pushNotificaitonViewController;
@property (nonatomic, strong) NSTimer *pushNotificationTimer;
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

- (void)hidePushNotificationView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.pushNotificaitonViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.pushNotificaitonViewController.view removeFromSuperview];
        self.pushNotificaitonViewController = nil;
    }];
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

#pragma mark - app launch methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"FqdCInc5wYV5Hk2kDVF0mIF2l5WvqhIFyXTaUhw9" clientKey:@"78xx8sl0wFaqK97BWnqev2C4I3LPv9XpEhIv76Vv"];

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

    return YES;
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
