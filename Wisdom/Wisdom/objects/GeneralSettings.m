//
//  GeneralSettings.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "GeneralSettings.h"

static NSString * const kOnboardingCompleted = @"onboardingCompleted";
static NSString * const kQuotesScreen = @"quotesScreen";
static NSString * const kPushNotificationShow = @"PushNotificationShow";

static NSString * const kAppLaunchDate = @"AppLaunchDate";

@implementation GeneralSettings

+ (BOOL)onboardingCompleted
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kOnboardingCompleted];
}

+ (void)setOnboardingCompleted:(BOOL)completed
{
    [[NSUserDefaults standardUserDefaults] setBool:completed forKey:kOnboardingCompleted];

    [[NSUserDefaults standardUserDefaults] setBool:completed forKey:kQuotesScreen];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)showQuotesScreen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kQuotesScreen];
}

+ (BOOL)showPushNotificationView
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kPushNotificationShow];
}

+ (void)setShowPushNotificationAllowed:(BOOL)allowed
{
    [[NSUserDefaults standardUserDefaults] setBool:allowed forKey:kPushNotificationShow];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setAppLaunchDate
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kAppLaunchDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate*)appLaunchDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAppLaunchDate];
}

@end
