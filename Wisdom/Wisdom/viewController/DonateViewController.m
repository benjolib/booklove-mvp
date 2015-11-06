//
//  DonateViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 07/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "DonateViewController.h"

@implementation DonateViewController

- (IBAction)donateButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://smile.amazon.com/ap/signin?_encoding=UTF8&openid.assoc_handle=amzn_smile_mobile&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fsmile.amazon.com%2Fgp%2Faw%2Fch%2Fpost-signin%3Fie%3DUTF8%26ein%3D%26origUri%3D%252F&siteState="]];

    [TRACKER trackDonateButtonPressed];
}

- (IBAction)closeButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];

    [TRACKER trackDonateViewClosed];
}

#pragma mark - view methods
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
