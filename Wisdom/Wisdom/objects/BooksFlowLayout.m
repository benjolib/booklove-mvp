//
//  BooksFlowLayout.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BooksFlowLayout.h"

@implementation BooksFlowLayout

- (void)awakeFromNib
{
    [super awakeFromNib];

}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        self.minimumInteritemSpacing = 10.0;
        self.minimumLineSpacing = 10.0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);
    }
    return self;
}

- (CGSize)itemSize
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame) - 40.0, CGRectGetHeight(self.collectionView.frame) - 60.0);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;

    UICollectionViewLayoutAttributes *attributes = [[UICollectionViewLayoutAttributes alloc] init];
    attributes.frame = CGRectMake(row * self.itemSize.width + (row == 0 ? 20.0 : 40.0), 30.0, self.itemSize.width, self.itemSize.height);

    return attributes;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    CGSize collectionViewSize = self.collectionView.bounds.size;
//    CGFloat proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width * 0.5f;
//
//    CGRect proposedRect = self.collectionView.bounds;
//
//    // Comment out if you want the collectionview simply stop at the center of an item while scrolling freely
//    // proposedRect = CGRectMake(proposedContentOffset.x, 0.0, collectionViewSize.width, collectionViewSize.height);
//
//    UICollectionViewLayoutAttributes *candidateAttributes;
//    for (UICollectionViewLayoutAttributes *attributes in [self layoutAttributesForElementsInRect:proposedRect])
//    {
//        // == Skip comparison with non-cell items (headers and footers) == //
//        if (attributes.representedElementCategory != UICollectionElementCategoryCell)
//        {
//            continue;
//        }
//
//        // == First time in the loop == //
//        if(!candidateAttributes)
//        {
//            candidateAttributes = attributes;
//            continue;
//        }
//
//        if (fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes.center.x - proposedContentOffsetCenterX))
//        {
//            candidateAttributes = attributes;
//        }
//    }
//
//    return CGPointMake(candidateAttributes.center.x - self.collectionView.bounds.size.width * 0.5f, proposedContentOffset.y);
//}

@end
