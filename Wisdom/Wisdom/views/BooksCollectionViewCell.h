//
//  BooksCollectionViewCell.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendedByView.h"
#import "LoadingImageView.h"
#import "BooksDetailView.h"
#import "PopupView.h"

@interface BooksCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet LoadingImageView *bookCoverImageView;
@property (nonatomic, weak) IBOutlet RecommendedByView *recommendedByView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *recommendWrapperViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UIView *recommendWrapperView;
@property (nonatomic, weak) IBOutlet UIView *recommendSeparatorLineView;

@property (nonatomic, weak) IBOutlet PopupView *normalView;
@property (nonatomic, weak) IBOutlet BooksDetailView *booksDetailView;

@property (nonatomic) BOOL cellFlipped;

- (void)flipToShowDetailViewWithBookObject:(BookObject*)book;
- (void)flipToShowNormalView;

- (void)updateViewWithBook:(BookObject*)book;

- (void)updateBookmarkIconOnBookDetailsWithBookObject:(BookObject*)bookObject;

@end
