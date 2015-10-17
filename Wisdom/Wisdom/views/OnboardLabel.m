//
//  OnboardLabel.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 23/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "OnboardLabel.h"

@interface OnboardLabel ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end

@implementation OnboardLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setCompleted:NO];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    self.circleLayer.hidden = YES;
}

- (void)setCompleted:(BOOL)completed
{
    if (completed) {
        self.circleLayer.fillColor = [UIColor redSelectionColor].CGColor;
        self.circleLayer.strokeColor = [UIColor clearColor].CGColor;
        self.text = @" ";
    } else {
        self.circleLayer.fillColor = [UIColor clearColor].CGColor;
        self.circleLayer.strokeColor = [UIColor grayColorWithValue:155.0].CGColor;
    }
    self.circleLayer.hidden = NO;
}

- (CAShapeLayer*)circleLayer
{
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 4.0, 4.0) cornerRadius:4.0].CGPath;
        _circleLayer.frame = CGRectMake(CGRectGetWidth(self.frame)/2-2, CGRectGetHeight(self.frame)/2-2, 4.0, 4.0);
        _circleLayer.lineWidth = 1.0;
        [self.layer addSublayer:_circleLayer];
    }
    return _circleLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.circleLayer.frame = CGRectMake(CGRectGetWidth(self.frame)/2-2, CGRectGetHeight(self.frame)/2-2, 4.0, 4.0);
}

@end
