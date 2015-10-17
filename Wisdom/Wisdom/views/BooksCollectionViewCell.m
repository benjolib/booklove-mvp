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

    self.booksDetailView.coverImageView.image = nil;
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

- (void)showNormalView
{
    if (self.cellFlipped) {

    }
    [UIView transitionFromView:self.booksDetailView
                        toView:self.normalView
                      duration:0.0
                       options:UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionNone
                    completion:^(BOOL finished) {
                        self.cellFlipped = NO;
                    }];
}

- (void)showFlippedDetailView
{
    [UIView transitionFromView:self.normalView
                        toView:self.booksDetailView
                      duration:0.0
                       options:UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionNone
                    completion:^(BOOL finished) {
                        self.cellFlipped = YES;
                    }];
}

- (void)updateViewWithBook:(BookObject*)book
{
    [self.booksDetailView setupViewWithBookObject:book];
}

- (void)updateBookmarkIconOnBookDetailsWithBookObject:(BookObject*)bookObject
{
    [self.booksDetailView updateBookmarkIconWithBookObject:bookObject];
}

@end
