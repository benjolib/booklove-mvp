//
//  UIColor+AppColors.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AppColors)

#pragma mark - global
+ (UIColor*)backgroundColor;
+ (UIColor*)redSelectionColor;
+ (UIColor*)globalGreenColor;
+ (UIColor*)backgroundGreenColor;

+ (UIColor*)colorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor*)grayColorWithValue:(CGFloat)value;

#pragma mark - onboarding colors


@end
