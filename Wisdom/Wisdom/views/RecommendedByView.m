//
//  RecommendedByView.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "RecommendedByView.h"

@implementation RecommendedByView

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.recommendedView.layer.cornerRadius = CGRectGetHeight(self.recommendedView.frame)/2;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.recommendedView.layer.cornerRadius = CGRectGetHeight(self.recommendedView.frame)/2;
}

@end
