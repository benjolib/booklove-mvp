//
//  ParseDownloadManager.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ParseDownloadManager.h"
#import "BookCollectionObject.h"
#import "BookObject.h"
#import "BookGenre.h"

@interface ParseDownloadManager ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ParseDownloadManager

- (NSDateFormatter*)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"dd-MMM-YYYY";
    }

    return _dateFormatter;
}

#pragma mark - downloading methods
- (void)downloadBooksForDate:(NSDate*)date genre:(BookGenre*)bookGenre withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Booklove"];

    [query whereKey:@"Date_Published" equalTo:[self.dateFormatter stringFromDate:date]];
    if (bookGenre.genreName) {
        [query whereKey:@"Category" equalTo:[bookGenre.genreName stringByReplacingOccurrencesOfString:@" " withString:@""]];
    } else {
        [query whereKey:@"Category" equalTo:@"Classics"];
    }

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (PFObject *parseObject in objects) {
            [tempArray addObject:[BookObject bookObjectWithParse:parseObject]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(tempArray, error.localizedDescription);
            }
        });
    }];
}

- (void)downloadAllBooksForDate:(NSDate*)date genre:(BookGenre*)currentBookGenre withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Booklove"];
    [query whereKey:@"Date_Published" equalTo:[self.dateFormatter stringFromDate:date]];
    [query whereKey:@"Category" notEqualTo:currentBookGenre.genreName];

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (PFObject *parseObject in objects) {
            [tempArray addObject:[BookObject bookObjectWithParse:parseObject]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(tempArray, error.localizedDescription);
            }
        });
    }];
}

- (void)downloadBooksForCollectionID:(NSString*)collectionID withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Booklove"];
    [query whereKey:@"parentCollectionIDs" containedIn:@[collectionID]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (PFObject *parseObject in objects) {
            [tempArray addObject:[BookObject bookObjectWithParse:parseObject]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(tempArray, error.localizedDescription);
            }
        });
    }];
}

- (void)downloadQuotes
{
    PFQuery *query = [PFQuery queryWithClassName:@"quotes"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [PFObject pinAllInBackground:objects];
    }];
}

- (void)downloadCollectionsWithCompletionBlock:(void (^)(NSArray *collections, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"collections"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (PFObject *parseObject in objects) {
            [tempArray addObject:[BookCollectionObject collectionObjectWithParse:parseObject]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(tempArray, error.localizedDescription);
            }
        });
    }];
}

@end
