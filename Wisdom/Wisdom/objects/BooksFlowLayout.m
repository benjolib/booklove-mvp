//
//  BooksFlowLayout.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BooksFlowLayout.h"

@interface BooksFlowLayout ()
@property (assign, nonatomic) CGSize lastCollectionViewSize;
@end

@implementation BooksFlowLayout

+ (BooksFlowLayout *)layoutConfiguredWithCollectionView:(UICollectionView *)collectionView
                                               itemSize:(CGSize)itemSize
                                     minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    BooksFlowLayout *layout = [BooksFlowLayout new];
    collectionView.collectionViewLayout = layout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = minimumLineSpacing;
    layout.itemSize = itemSize;
    layout.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;

    return layout;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self configureDefaults];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureDefaults];
}

- (void)configureDefaults {
    self.scalingOffset = 800;
    self.minimumScaleFactor = 0.8;
    self.scaleItems = YES;
}

- (CGSize)itemSize
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame) - 40.0, CGRectGetHeight(self.collectionView.frame) - 40.0);
}

#pragma mark - Invalidation
- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context {
    [super invalidateLayoutWithContext:context];

    CGSize currentCollectionViewSize = self.collectionView.bounds.size;
    if (!CGSizeEqualToSize(currentCollectionViewSize, self.lastCollectionViewSize)) {
        [self configureInset];
        self.lastCollectionViewSize = currentCollectionViewSize;
    }
}

- (void)configureInset {
    CGFloat inset = self.collectionView.bounds.size.width/2 - self.itemSize.width/2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset); // UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(-inset, 0);
}

#pragma mark - UICollectionViewLayout (UISubclassingHooks)
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGSize collectionViewSize = self.collectionView.bounds.size;
    CGFloat proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width / 2;
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, 0, collectionViewSize.width, collectionViewSize.height);

    UICollectionViewLayoutAttributes *candidateAttributes;
    for (UICollectionViewLayoutAttributes *attributes in [self layoutAttributesForElementsInRect:proposedRect]) {
        if (attributes.representedElementCategory != UICollectionElementCategoryCell) continue;

        if (!candidateAttributes) {
            candidateAttributes = attributes;
            continue;
        }

        if (fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
            candidateAttributes = attributes;
        }
    }

    proposedContentOffset.x = candidateAttributes.center.x - self.collectionView.bounds.size.width / 2;

    CGFloat offset = proposedContentOffset.x - self.collectionView.contentOffset.x;

    if ((velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0)) {
        CGFloat pageWidth = self.itemSize.width + self.minimumLineSpacing;
        proposedContentOffset.x += velocity.x > 0 ? pageWidth : -pageWidth;
    }

    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (!self.scaleItems)
        return [super layoutAttributesForElementsInRect:rect];

    NSArray *attributesArray = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect]
                                                    copyItems:YES];

    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
    CGFloat visibleCenterX = CGRectGetMidX(visibleRect);

    [attributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
        CGFloat distanceFromCenter = visibleCenterX - attributes.center.x;
        CGFloat absDistanceFromCenter = MIN(ABS(distanceFromCenter), self.scalingOffset);
        CGFloat scale = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1;
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
    }];

    return attributesArray;
}

@end
