//
//  ParseLocalStoreManager.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ParseLocalStoreManager.h"
#import "Reachability.h"
#import "QuoteObject.h"
#import "BookObject.h"
#include <stdlib.h>

@implementation ParseLocalStoreManager

- (void)loadLibraryBooksWithCompletionBlock:(void (^)(NSArray *booksArray, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Books"];
    if (![self isInternetConnectionAvailable]) {
        [query fromLocalDatastore];
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

- (void)loadRandomQuoteWithCompletionBlock:(void (^)(QuoteObject *quote))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Quotes"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0) {
            NSInteger randomNumber = [self randomNumberTillNumber:objects.count];
            PFObject *randomParseObject = [objects objectAtIndex:randomNumber];

            QuoteObject *quoteObject = [[QuoteObject alloc] initWithPFObject:randomParseObject];
            if (completionBlock) {
                completionBlock(quoteObject);
            }
        } else {
            if (completionBlock) {
                completionBlock(nil);
            }
        }
    }];
}

- (void)storeParseObjectLocally:(PFObject*)parseObject
{

}

- (void)removeObjectFromLocalStore:(BookObject*)parseObject completionBlock:(void (^)(BOOL succeeded, NSString *errorMessage))completionBlock
{
    [[PFObject objectWithoutDataWithObjectId:parseObject.parseID] unpinInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (completionBlock) {
            completionBlock(succeeded, error.localizedDescription);
        }
    }];

}

- (BOOL)isObjectSavedLocally:(PFObject*)parseObject
{
    return NO;
}

#pragma mark - private methods
- (NSInteger)randomNumberTillNumber:(NSInteger)limitNumber
{
    return arc4random() % limitNumber;
}

- (BOOL)isInternetConnectionAvailable
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
