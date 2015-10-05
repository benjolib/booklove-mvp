//
//  BuyButton.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 30/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BuyButton.h"

@implementation BuyButton

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setBackgroundColor:[UIColor globalGreenColor]];

    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateHighlighted];
}

@end
