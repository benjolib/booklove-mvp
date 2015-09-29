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

+ (void)setAppLaunchDate;
+ (NSDate*)appLaunchDate;

@end
