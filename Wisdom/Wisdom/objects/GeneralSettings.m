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
static NSString * const kInviteFriendScreen = @"InviteFriendScreen";
static NSString * const kFavoriteCategory = @"FavoriteCategory";

static NSString * const kEmailOverlay = @"EmailOverlay";

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

+ (NSDate*)appLaunchDate
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    dateComponents.day = 23;
    dateComponents.month = 10;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
//    return [[NSUserDefaults standardUserDefaults] objectForKey:kAppLaunchDate];
}

+ (BOOL)inviteFriendScreenNeedsToShow
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreen] >= 3) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)increaseInviteFriendShowCount
{
    NSInteger currentShowCount = [[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreen];
    if (currentShowCount < 3) {
        currentShowCount++;
        [[NSUserDefaults standardUserDefaults] setInteger:currentShowCount forKey:kInviteFriendScreen];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)resetInviteFriendShowCount
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kInviteFriendScreen];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*)appStoreURL
{
    return @"NEED TO ADD THE APP STORE URL HERE__";
}

+ (void)setFavoriteCategory:(NSString*)categoryString
{
    [[NSUserDefaults standardUserDefaults] setObject:categoryString forKey:kFavoriteCategory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*)favoriteCategory
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kFavoriteCategory];
}

+ (BOOL)emailOverlayWasCompleted
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kEmailOverlay];
}

+ (void)setEmailOverlayWasCompleted
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kEmailOverlay];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
