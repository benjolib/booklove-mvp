//
//  InviteFriendViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InviteFriendButton;

@interface InviteFriendViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *inviteButton;
@property (nonatomic, weak) IBOutlet UIView *backgroundView;

@property (nonatomic, weak) IBOutlet UIView *buttonContainerView;
@property (nonatomic, strong) IBOutletCollection(InviteFriendButton) NSArray *buttonsArray;

- (IBAction)inviteButtonPressed:(UIButton*)button;
- (IBAction)closeButtonPressed:(UIButton*)button;

@end
