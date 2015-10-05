//
//  EmailViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "EmailViewController.h"
#import "UITextField+Helper.h"
#import "EmailTextfield.h"
#import <Parse/Parse.h>

@interface EmailViewController ()
@property (nonatomic) CGFloat emailFieldBottomConstraintDefaultValue;
@end

@implementation EmailViewController

- (IBAction)submitButtonPressed:(id)sender
{
    if (![self.emailField isEmpty])
    {
        if ([self.emailField isEmailValid])
        {
            [self hideKeyboard];

            // send the email address to somewhere
            PFUser *user = [PFUser currentUser];
            user.email = self.emailField.text;
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [self showThankYouScreen];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        else
        {
            // not valid
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The email address you entered is not valid." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        // empty
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email is empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)closeButtonPressed:(UIButton*)button
{
    [self hideView];
}

- (void)showThankYouScreen
{
    self.thankYouView.hidden = NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideView];
    });
}

- (void)hideView
{
    [self.emailField resignFirstResponder];

    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - textfield methods
- (IBAction)textFieldDidChangeText:(UITextField*)textfield
{
    if ([textfield isEmailValid]) {
        textfield.textColor = [UIColor grayColorWithValue:151.0];
    } else {
        textfield.textColor = [UIColor redSelectionColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self submitButtonPressed:nil];
    return NO;
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.thankYouView.hidden = YES;
    self.emailFieldBottomConstraintDefaultValue = self.emailFieldBottomConstraint.constant;

    self.emailField.tintColor = [UIColor grayColorWithValue:151.0];
    [self addKeyboardObservers];
}

- (void)addKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillAppear:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGFloat keyboardHeight = keyboardSize.height;

    CGFloat emailFieldToBottomValue = CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.emailField.frame);

    if (self.emailFieldBottomConstraint.constant != self.emailFieldBottomConstraintDefaultValue) {
        return;
    }

    if (emailFieldToBottomValue < keyboardHeight) {
        self.emailFieldBottomConstraint.constant = (keyboardHeight - 10) - self.emailFieldBottomConstraintDefaultValue;
    }

    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.2 animations:^{
                                      self.descriptionLabel.alpha = 0.0;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
                                      [self.view layoutIfNeeded];
                                  }];
                              }
                              completion:nil];
}

- (void)hideKeyboard
{
    self.emailFieldBottomConstraint.constant = self.emailFieldBottomConstraintDefaultValue;
    self.titleLabel.alpha = 1.0;
    self.descriptionLabel.alpha = 1.0;

    [self.view layoutIfNeeded];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
