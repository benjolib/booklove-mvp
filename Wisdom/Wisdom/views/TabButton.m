//
//  TabButton.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "TabButton.h"

@implementation TabButton

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundColor = [UIColor whiteColor];
    [self setTitleColor:[UIColor grayColorWithValue:137.0] forState:UIControlStateNormal];

    if (IS_IPHONE_5) {
        UIFont *font = self.titleLabel.font;

        UIFont *newFont = [UIFont fontWithName:font.familyName size:font.pointSize-1];
        self.titleLabel.font = newFont;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self setTitleColor:[UIColor redSelectionColor] forState:UIControlStateNormal];
    } else {
        [self setTitleColor:[UIColor grayColorWithValue:137.0] forState:UIControlStateNormal];
    }
}

@end
