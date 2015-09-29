//
//  LibraryTableViewCell.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "LibraryTableViewCell.h"

@interface LibraryTableViewCell ()
@property (nonatomic, strong) CALayer *bottomBorderLayer;
@end

@implementation LibraryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.categoryLabel.textColor = [UIColor redSelectionColor];

    self.buyButton.layer.borderWidth = 1.0;
    self.buyButton.layer.borderColor = [UIColor globalGreenColor].CGColor;

    if (!self.bottomBorderLayer) {
        self.bottomBorderLayer = [CALayer layer];
        self.bottomBorderLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1.0);
        self.bottomBorderLayer.backgroundColor = [UIColor grayColorWithValue:239.0].CGColor;
        [self.layer addSublayer:self.bottomBorderLayer];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomBorderLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
