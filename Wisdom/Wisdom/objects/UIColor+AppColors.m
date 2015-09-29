//
//  UIColor+AppColors.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "UIColor+AppColors.h"

#define RGB(r, g, b) [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: 1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: a]

@implementation UIColor (AppColors)

+ (UIColor*)backgroundColor
{
    return RGB(243.0, 243.0, 243.0);
}

+ (UIColor*)backgroundGreenColor
{
    return [self globalGreenColor];
}

+ (UIColor*)redSelectionColor
{
    return RGB(181.0, 106.0, 100.0);
}

+ (UIColor*)globalGreenColor
{
    return RGB(112.0, 148.0, 146.0);
}

+ (UIColor*)colorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return RGB(red, green, blue);
}

+ (UIColor*)grayColorWithValue:(CGFloat)value
{
    return RGB(value, value, value);
}

@end
