//
//  GeneralSettings.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneralSettings : NSObject

+ (BOOL)onboardingCompleted;
+ (void)setOnboardingCompleted:(BOOL)completed;

+ (BOOL)showQuotesScreen;

+ (BOOL)showPushNotificationView;
+ (void)setShowPushNotificationAllowed:(BOOL)allowed;

+ (NSDate*)appLaunchDate;

+ (BOOL)inviteFriendScreenNeedsToShow;
+ (void)increaseInviteFriendShowCount;
+ (void)increaseInviteFriendShowFirstTimeCount;
+ (void)resetInviteFriendShowCount;

+ (NSString*)appStoreURL;

+ (NSString*)favoriteCategory;
+ (void)setFavoriteCategory:(NSString*)categoryString;

+ (BOOL)emailOverlayWasCompleted;
+ (void)setEmailOverlayWasCompleted;

+ (void)increaseEmailScreenCount;
+ (BOOL)emailOverlayShouldBeShown;

@end
