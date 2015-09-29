//
//  PushNotificationViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "PushNotificationViewController.h"
#import "AppDelegate.h"

@implementation PushNotificationViewController

- (IBAction)okButtonPressed:(UIButton*)button
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate askUserForPushNotifications];

    [GeneralSettings setShowPushNotificationAllowed:YES];
    [self hideNotificationView];
}

- (IBAction)notnowButtonPressed:(UIButton*)button
{
    [GeneralSettings setShowPushNotificationAllowed:NO];
    [self hideNotificationView];
}

- (IBAction)closeButtonPressed:(UIButton*)button
{
    [GeneralSettings setShowPushNotificationAllowed:NO];
    [self hideNotificationView];
}

- (void)hideNotificationView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundGreenColor];

    self.separatorView.backgroundColor = [UIColor globalGreenColor];

    self.notNowButton.backgroundColor = [UIColor whiteColor];
    [self.notNowButton setTitleColor:[UIColor globalGreenColor] forState:UIControlStateNormal];

    self.okButton.backgroundColor = [UIColor globalGreenColor];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
