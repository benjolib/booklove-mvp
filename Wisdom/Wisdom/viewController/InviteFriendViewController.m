//
//  InviteFriendViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "BuyButton.h"
#import "RatingButton.h"

@implementation InviteFriendViewController

- (IBAction)inviteButtonPressed:(UIButton*)button
{
    NSString *stringToShare = [NSString stringWithFormat:@"Hey! Get your daily book recommendation selected from the best literature ever written. %@", [GeneralSettings appStoreURL]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[stringToShare]
                                                                                         applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                                     UIActivityTypePrint,
                                                     UIActivityTypeCopyToPasteboard,
                                                     UIActivityTypeAssignToContact,
                                                     UIActivityTypePostToVimeo,
                                                     UIActivityTypePostToTencentWeibo,
                                                     UIActivityTypePostToFlickr,
                                                     UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityViewController animated:YES completion:NULL];
}

- (IBAction)closeButtonPressed:(UIButton*)button
{
    [self hideNotificationView];
}

- (IBAction)userSelectedButton:(RatingButton*)button
{
    for (RatingButton *ratingButton in self.buttonsArray) {
        ratingButton.selected = [button isEqual:ratingButton];
    }

    #warning Add tracking here

}

- (void)hideNotificationView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.view.backgroundColor = [UIColor backgroundGreenColor];

    self.buttonContainerView.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor grayColorWithValue:55.0];

    self.notLikelyLabel.textColor = [UIColor globalGreenColor];
    self.likelyLabel.textColor = [UIColor globalGreenColor];

    [self.inviteButton setTitle:@"INVITE A FRIEND" forState:UIControlStateNormal];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
