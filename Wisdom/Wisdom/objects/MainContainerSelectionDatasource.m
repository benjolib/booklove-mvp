//
//  MainContainerSelectionDatasource.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "MainContainerSelectionDatasource.h"
#import "NSDate+Helper.h"

@interface MainContainerSelectionDatasource ()
@property (nonatomic, strong, readwrite) NSArray *itemsToDisplay;
@end

@implementation MainContainerSelectionDatasource

- (void)loadItemsForSelectedItem:(MainContainerSelectedItem)selectedItem
{
    if (selectedItem == MainContainerSelectedItemDate) {
        self.itemsToDisplay = [self setupArrayForDates];
    } else {
        self.itemsToDisplay = @[@"Crime", @"Classics", @"Biography", @"Travel", @"Science"];
    }
}

- (id)objectAtIndexPath:(NSIndexPath*)indexPath
{
    return self.itemsToDisplay[indexPath.row];
}

- (NSIndexPath*)indexPathOfObject:(id)object
{
    return [NSIndexPath indexPathForItem:[self.itemsToDisplay indexOfObject:object] inSection:0];
}

- (NSArray*)setupArrayForDates
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar startOfDayForDate:[NSDate date]];

    NSMutableArray *tempArray = [NSMutableArray array];
    while (![date isDateEqualToDate:[GeneralSettings appLaunchDate]]) {
        [tempArray addObject:date];
        date = [calendar dateByAddingUnit:NSDayCalendarUnit value:-1 toDate:date options:0];
    }

    if (tempArray.count == 0) {
        [tempArray addObject:[NSDate date]];
    }
    return tempArray;
}



@end
