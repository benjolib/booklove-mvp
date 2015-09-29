//
//  PopupView.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 23/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.14].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 1.0;

    self.backgroundColor = [UIColor whiteColor];
}

@end
