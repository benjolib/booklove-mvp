//
//  OnboardingFlowLayout.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 05/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "OnboardingFlowLayout.h"

@implementation OnboardingFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.minimumLineSpacing = 5.0;
        self.minimumInteritemSpacing = 5.0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
    }
    return self;
}

- (CGSize)itemSize
{
    UIImage *image = [UIImage imageNamed:@"c1"];
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;

    CGFloat imageRatio = imageHeight / imageWidth;

    imageWidth = (CGRectGetWidth(self.collectionView.frame) - 20.0) /4;
    imageHeight = imageWidth * imageRatio;

    if (imageHeight > CGRectGetHeight(self.collectionView.frame)/2 - 10) {
        imageHeight = CGRectGetHeight(self.collectionView.frame)/2 - 5;
    }

    return CGSizeMake(imageWidth, imageHeight);
}

@end
