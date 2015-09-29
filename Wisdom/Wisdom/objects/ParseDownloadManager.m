//
//  ParseDownloadManager.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ParseDownloadManager.h"
#import "BookCollectionObject.h"

@implementation ParseDownloadManager

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
