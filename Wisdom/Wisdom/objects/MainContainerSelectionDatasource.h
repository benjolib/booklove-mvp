//
//  MainContainerSelectionDatasource.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MainContainerSelectedItem) {
    MainContainerSelectedItemDate,
    MainContainerSelectedItemGenre
};

@interface MainContainerSelectionDatasource : NSObject

@property (nonatomic, strong, readonly) NSArray *itemsToDisplay;

- (void)loadItemsForSelectedItem:(MainContainerSelectedItem)selectedItem;

- (id)objectAtIndexPath:(NSIndexPath*)indexPath;
- (NSIndexPath*)indexPathOfObject:(id)object;

@end
