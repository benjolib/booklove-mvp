//
//  InviteFriendViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopupView, InviteFriendButton, RatingButton, BuyButton;

@interface InviteFriendViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet BuyButton *inviteButton;
@property (nonatomic, weak) IBOutlet PopupView *backgroundView;
@property (nonatomic, weak) IBOutlet UILabel *notLikelyLabel;
@property (nonatomic, weak) IBOutlet UILabel *likelyLabel;

@property (nonatomic, weak) IBOutlet UIView *buttonContainerView;
@property (nonatomic, strong) IBOutletCollection(RatingButton) NSArray *buttonsArray;

- (IBAction)inviteButtonPressed:(UIButton*)button;
- (IBAction)closeButtonPressed:(UIButton*)button;

- (IBAction)userSelectedButton:(RatingButton*)button;

@end
