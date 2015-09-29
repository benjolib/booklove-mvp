//
//  PushNotificationViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupView.h"

@interface PushNotificationViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UIButton *notNowButton;
@property (nonatomic, weak) IBOutlet UIButton *okButton;
@property (nonatomic, weak) IBOutlet UIView *separatorView;
@property (nonatomic, weak) IBOutlet PopupView *backgroundView;

- (IBAction)okButtonPressed:(UIButton*)button;
- (IBAction)notnowButtonPressed:(UIButton*)button;
- (IBAction)closeButtonPressed:(UIButton*)button;

- (void)hideNotificationView;

@end
