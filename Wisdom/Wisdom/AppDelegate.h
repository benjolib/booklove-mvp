//
//  AppDelegate.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)askUserForPushNotifications;

- (void)showPushNotificationView;

- (void)hideQuotesScreen;
- (void)hidePushNotificationView;

@end

