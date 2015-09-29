//
//  NSDate+Helper.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

- (BOOL)isDateToday;
- (BOOL)isDateYesterday;

- (BOOL)isDateEqualToDate:(NSDate*)date;

@end
