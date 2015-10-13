//
//  BooksFlowLayout.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksFlowLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) CGFloat scalingOffset; //default is 200; for offsets >= scalingOffset scale factor is minimumScaleFactor
@property (assign, nonatomic) CGFloat minimumScaleFactor; //default is 0.7
@property (assign, nonatomic) BOOL scaleItems; //default is YES

+ (BooksFlowLayout *)layoutConfiguredWithCollectionView:(UICollectionView *)collectionView
                                               itemSize:(CGSize)itemSize
                                     minimumLineSpacing:(CGFloat)minimumLineSpacing;

@end
