//
//  LoadingImageView.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "LoadingImageView.h"

@interface LoadingImageView ()
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@end

@implementation LoadingImageView

- (void)showLoadingIndicator
{
    [self.loadingIndicator startAnimating];
    self.loadingIndicator.hidden = YES;
}

- (void)hideLoadingIndicator
{
    [self.loadingIndicator stopAnimating];
    self.loadingIndicator.hidden = YES;
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    [self hideLoadingIndicator];
}

#pragma mark - setup methods
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupLoadingIndicator];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (!self.image) {
        [self showLoadingIndicator];
    }
}

- (void)setupLoadingIndicator
{
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingIndicator.frame = CGRectMake(CGRectGetWidth(self.frame)/2-15.0, CGRectGetHeight(self.frame)/2-15.0, 30.0, 30.0);
    [self addSubview:self.loadingIndicator];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.loadingIndicator.frame = CGRectMake(CGRectGetWidth(self.frame)/2-15.0, CGRectGetHeight(self.frame)/2-15.0, 30.0, 30.0);
}

@end
