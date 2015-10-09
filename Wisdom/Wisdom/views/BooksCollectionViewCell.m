//
//  BooksCollectionViewCell.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BooksCollectionViewCell.h"
#import "RecommendedByView.h"
#import "BooksDetailView.h"

@implementation BooksCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.cellFlipped = NO;
    self.bookCoverImageView.image = nil;
    self.recommendedByView.recommendedView.image = nil;
}

- (NSTimeInterval)flipDuration
{
    return 0.6;
}

- (void)flipToShowDetailViewWithBookObject:(BookObject*)book
{
    [self updateViewWithBook:book];

    [UIView transitionFromView:self.normalView
                        toView:self.booksDetailView
                      duration:[self flipDuration]
                       options:UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionCurveEaseOut
                    completion:^(BOOL finished) {
                        self.cellFlipped = YES;
    }];
}

- (void)flipToShowNormalView
{
    [UIView transitionFromView:self.booksDetailView
                        toView:self.normalView
                      duration:[self flipDuration]
                       options:UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionCurveEaseOut
                    completion:^(BOOL finished) {
                        self.cellFlipped = NO;
                    }];
}

- (void)updateViewWithBook:(BookObject*)book
{
    [self.booksDetailView setupViewWithBookObject:book];
}

- (void)setIsStoredLocally:(BOOL)isStoredLocally
{
    if (isStoredLocally) {

    } else {

    }
}

@end
