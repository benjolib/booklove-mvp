//
//  RatingButton.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 23/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "RatingButton.h"

@implementation RatingButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor globalGreenColor].CGColor;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor globalGreenColor]];
    } else {
        [self setTitleColor:[UIColor globalGreenColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
