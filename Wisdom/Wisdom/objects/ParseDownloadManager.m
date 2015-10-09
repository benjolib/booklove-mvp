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

@implementation ParseDownloadManager

#pragma mark - downloading methods
- (void)downloadBooksForDate:(NSDate*)date genre:(BookGenre*)bookGenre withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"books"];

//    [query whereKey:@"createdAt" equalTo:date];
    if (bookGenre.genreName) {
        [query whereKey:@"category" equalTo:bookGenre.genreName];
    } else {
        [query whereKey:@"category" equalTo:@"crime"];
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

- (void)downloadBooksForCollectionID:(NSString*)collectionID withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"books"];
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
    PFQuery *query = [PFQuery queryWithClassName:@"Quotes"];
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
