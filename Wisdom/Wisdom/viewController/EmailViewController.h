//
//  EmailViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmailTextfield;

@interface EmailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@property (nonatomic, weak) IBOutlet EmailTextfield *emailField;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *emailFieldBottomConstraint;
@property (nonatomic, weak) IBOutlet UIView *thankYouView;

- (IBAction)submitButtonPressed:(id)sender;

@end
