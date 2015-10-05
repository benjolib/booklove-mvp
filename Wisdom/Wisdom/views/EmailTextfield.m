//
//  EmailTextfield.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 05/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "EmailTextfield.h"

@interface EmailTextfield ()
@property (nonatomic, strong) CALayer *bottomBorderLayer;
@end

@implementation EmailTextfield

- (void)awakeFromNib
{
    [super awakeFromNib];

    UIView *customLeftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 1.0)];
    self.leftView = customLeftView;
    self.leftViewMode = UITextFieldViewModeAlways;

    CALayer *bottomBorderLayer = [CALayer layer];
    bottomBorderLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1.0);
    bottomBorderLayer.backgroundColor = [[UIColor grayColorWithValue:151.0] colorWithAlphaComponent:0.3].CGColor;
    [self.layer addSublayer:bottomBorderLayer];
    self.bottomBorderLayer = bottomBorderLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomBorderLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1.0);
}

@end
