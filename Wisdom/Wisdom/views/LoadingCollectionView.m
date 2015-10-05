//
//  LoadingCollectionView.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "LoadingCollectionView.h"

@interface LoadingCollectionView ()
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicatorView;
@end

@implementation LoadingCollectionView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupLoadingIndicator];
    }
    return self;
}

- (void)showLoadingIndicator
{
    self.loadingIndicatorView.alpha = 1.0;
    self.loadingIndicatorView.hidden = NO;
    [self bringSubviewToFront:self.loadingIndicatorView];
    [self startRefreshing];
}

- (void)hideLoadingIndicator
{
    [self stopRefreshing];
    self.loadingIndicatorView.alpha = 0.0;
}

#pragma mark - private methods
- (void)setupLoadingIndicator
{
    [self addSubview:self.loadingIndicatorView];
    [self adjustSizeOfLoadingIndicator];
    self.loadingIndicatorView.alpha = 0.0;
}

- (UIActivityIndicatorView*)loadingIndicatorView
{
    if (!_loadingIndicatorView) {
        _loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }

    return _loadingIndicatorView;
}

- (void)adjustSizeOfLoadingIndicator
{
    self.loadingIndicatorView.frame = CGRectMake(CGRectGetWidth(self.frame)/2 - CGRectGetWidth(self.loadingIndicatorView.frame)/2, CGRectGetHeight(self.frame)/2-CGRectGetHeight(self.loadingIndicatorView.frame)/2, 30.0, 30.0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustSizeOfLoadingIndicator];
}

- (void)startRefreshing
{
    [self.loadingIndicatorView startAnimating];
}

- (void)stopRefreshing
{
    [self.loadingIndicatorView stopAnimating];
}

@end
