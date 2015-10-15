//
//  BooksDetailView.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 30/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "PopupView.h"

#import "RecommendedByView.h"
#import "BuyButton.h"
#import "LoadingImageView.h"
#import "BookObject.h"

@interface BooksDetailView : PopupView

@property (nonatomic, weak) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailLabel;
@property (nonatomic, weak) IBOutlet RecommendedByView *recommendedView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionTitleLabel;
@property (nonatomic, weak) IBOutlet BuyButton *buyButton;
@property (nonatomic, weak) IBOutlet UIButton *bookmarkButton;
@property (nonatomic, weak) IBOutlet LoadingImageView *coverImageView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *recommendWrapperViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UIView *recommendWrapperView;

- (void)setupViewWithBookObject:(BookObject*)bookObject;
- (void)updateBookmarkIconWithBookObject:(BookObject*)bookObject;

- (IBAction)buyNowButtonPressed;

@end
