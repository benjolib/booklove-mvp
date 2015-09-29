//
//  SelectionCollectionViewCell.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "SelectionCollectionViewCell.h"

@implementation SelectionCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.3];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.titleLabel.textColor = [UIColor redSelectionColor];
    } else {
        self.titleLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
}

@end
