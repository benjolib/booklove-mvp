//
//  BooksDetailView.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 30/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BooksDetailView.h"
#import <Haneke/UIImageView+Haneke.h>

@interface BooksDetailView ()
@property (nonatomic, strong) CALayer *topBorderLayer;
@property (nonatomic, strong) CALayer *bottomBorderLayer;
@property (nonatomic, weak) BookObject *bookToDisplay;
@end

@implementation BooksDetailView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.recommendWrapperView.backgroundColor = [UIColor clearColor];

    CALayer *topBorderLayer = [CALayer layer];
    topBorderLayer.backgroundColor = [UIColor grayColorWithValue:187.0].CGColor;
    topBorderLayer.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.recommendWrapperView.frame), 1.0);
    [self.recommendWrapperView.layer addSublayer:topBorderLayer];
    self.topBorderLayer = topBorderLayer;

    CALayer *bottomBorderLayer = [CALayer layer];
    bottomBorderLayer.backgroundColor = [UIColor grayColorWithValue:187.0].CGColor;
    bottomBorderLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.recommendWrapperView.frame)-1, CGRectGetWidth(self.recommendWrapperView.frame), 1.0);
    [self.recommendWrapperView.layer addSublayer:bottomBorderLayer];
    self.bottomBorderLayer = bottomBorderLayer;
}

- (void)setupViewWithBookObject:(BookObject*)bookObject
{
    self.bookTitleLabel.text = bookObject.bookTitle;
    self.yearLabel.text = [NSString stringWithFormat:@"%@", bookObject.bookYear];
    self.authorLabel.text = bookObject.author;

    self.detailLabel.text = bookObject.sentence;
    self.descriptionLabel.text = bookObject.bookDescription;
    [self layoutIfNeeded];

    [self.coverImageView hnk_setImageFromURL:[NSURL URLWithString:bookObject.imageURL]];

    if (bookObject.price) {
        [self.buyButton setTitle:[NSString stringWithFormat:@"BUY FOR $ %@", bookObject.price] forState:UIControlStateNormal];
    } else {
        [self.buyButton setTitle:@"BUY IT" forState:UIControlStateNormal];
    }

    if ([bookObject isRecommended]) {
        // update the recommended view
        [self.recommendedView.recommendedView hnk_setImageFromURL:[NSURL URLWithString:bookObject.recommendedByUser.imageURL]];
        self.recommendedView.titleLabel.text = bookObject.recommendedByUser.name;
    } else {
        self.recommendWrapperViewHeightConstraint.constant = 0.0;
        [self layoutIfNeeded];
    }

    self.bookToDisplay = bookObject;
}

- (IBAction)buyNowButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.bookToDisplay.linkURL]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topBorderLayer.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.recommendWrapperView.frame), 1.0);
    self.bottomBorderLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.recommendWrapperView.frame)-1, CGRectGetWidth(self.recommendWrapperView.frame), 1.0);

    self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descriptionLabel.frame);
    [self layoutIfNeeded];
}

@end
