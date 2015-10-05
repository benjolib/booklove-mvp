//
//  BookCollectionTableViewCell.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BookCollectionTableViewCell.h"

@implementation BookCollectionTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.coverImageView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.14].CGColor;
    self.coverImageView.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.coverImageView.layer.shadowRadius = 2.0;
    self.coverImageView.layer.shadowOpacity = 1.0;

    self.coverImageView.backgroundColor = [UIColor whiteColor];
}

@end
