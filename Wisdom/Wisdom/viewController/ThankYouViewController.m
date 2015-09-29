//
//  ThankYouViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@end

@implementation ThankYouViewController

- (IBAction)closeButtonPressed:(UIButton*)button
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
}

@end
