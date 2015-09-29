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

@interface BooksCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet LoadingImageView *bookCoverImageView;
@property (nonatomic, weak) IBOutlet RecommendedByView *recommendedByView;

@end
