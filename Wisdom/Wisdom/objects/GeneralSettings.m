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
static NSString * const kInviteFriendScreenFirstCounter = @"InviteFriendScreenFirstCounter";
static NSString * const kFavoriteCategory = @"FavoriteCategory";

static NSString * const kEmailOverlay = @"EmailOverlay";
static NSString * const kEmailOverlayCounter = @"EmailOverlayCounter";

static NSString * const kAppLaunchDate = @"AppLaunchDate";

#define kInviteFriendLimit 8

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
}

+ (BOOL)inviteFriendScreenNeedsToShow
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreenFirstCounter] >= 3 && [[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreenFirstCounter] < 4) {
        return YES;
    }

    if ([[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreen] >= kInviteFriendLimit) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)increaseInviteFriendShowFirstTimeCount
{
    NSInteger currentShowCount = [[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreenFirstCounter];
    if (currentShowCount <= 3) {
        currentShowCount++;
        [[NSUserDefaults standardUserDefaults] setInteger:currentShowCount forKey:kInviteFriendScreenFirstCounter];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)increaseInviteFriendShowCount
{
    NSInteger currentShowCount = [[NSUserDefaults standardUserDefaults] integerForKey:kInviteFriendScreen];
    if (currentShowCount <= kInviteFriendLimit) {
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
    return [NSString stringWithFormat:@"itms://itunes.apple.com/us/app/apple-store/id%@?mt=8", @"1048146918"];
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

#pragma mark - email
+ (void)increaseEmailScreenCount
{
    NSInteger currentShowCount = [[NSUserDefaults standardUserDefaults] integerForKey:kEmailOverlayCounter];
    if (currentShowCount <= 3) {
        currentShowCount++;
        [[NSUserDefaults standardUserDefaults] setInteger:currentShowCount forKey:kEmailOverlayCounter];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)emailOverlayShouldBeShown
{
    if (![self emailOverlayWasCompleted] || [[NSUserDefaults standardUserDefaults] integerForKey:kEmailOverlayCounter] >= 4) {
        [self resetEmailCount];
        return YES;
    } else {
        return NO;
    }
}

+ (void)resetEmailCount
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kEmailOverlayCounter];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
