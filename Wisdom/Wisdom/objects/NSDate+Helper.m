//
//  NSDate+Helper.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

- (BOOL)isDateToday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];

    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];
    NSDate *passedDate = [cal dateFromComponents:components];

    if([today isEqualToDate:passedDate])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isDateYesterday
{
    NSDateComponents *componentsForYesterday = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSDateComponents *componentsForToday = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];

    if ((componentsForToday.day == (componentsForYesterday.day + 1)) && (componentsForToday.month == componentsForYesterday.month) && (componentsForToday.year == componentsForYesterday.year))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isDateEqualToDate:(NSDate*)date
{
    NSDateComponents *componentsForYesterday = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSDateComponents *componentsForToday = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];

    if ((componentsForToday.day == componentsForYesterday.day) && (componentsForToday.month == componentsForYesterday.month) && (componentsForToday.year == componentsForYesterday.year)) {
        return YES;
    } else {
        return NO;
    }
}

@end
