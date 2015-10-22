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

@interface ParseLocalStoreManager ()
@property (nonatomic, strong) NSMutableArray *locallySavedObjectIDs;
@end

@implementation ParseLocalStoreManager

+ (instancetype)sharedManager
{
    static ParseLocalStoreManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self fetchSavedBooksObjectIDs];
    }
    return self;
}

- (NSMutableArray*)locallySavedObjectIDs
{
    if (!_locallySavedObjectIDs) {
        _locallySavedObjectIDs = [[NSMutableArray alloc] init];
    }

    return _locallySavedObjectIDs;
}

- (void)loadLibraryBooksWithCompletionBlock:(void (^)(NSArray *booksArray, NSString *errorMessage))completionBlock
{
    PFQuery *query = [PFQuery queryWithClassName:@"Booklove"];
    [query fromLocalDatastore];
    [query orderByDescending:@"savedDate"];
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
    PFQuery *query = [PFQuery queryWithClassName:@"quotes"];
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

- (void)storeBookObjectLocally:(BookObject*)book
{
    [self.locallySavedObjectIDs addObject:book.parseID];

    PFObject *parseObject = [book convertToParseObject];
    [parseObject setObject:[NSDate date] forKey:@"savedDate"];
    [parseObject pinInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded) {
            [self.locallySavedObjectIDs removeObject:book.parseID];
        }

        [self fetchSavedBooksObjectIDs];
    }];
}

- (void)removeObjectFromLocalStore:(BookObject*)bookObject
{
    [self.locallySavedObjectIDs removeObject:bookObject.parseID];

    [[bookObject convertToParseObject] unpinInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self.locallySavedObjectIDs removeObject:bookObject.parseID];
        } else {
            [self.locallySavedObjectIDs addObject:bookObject.parseID];
        }
        [self fetchSavedBooksObjectIDs];
    }];
}

- (BOOL)isBookSavedLocally:(BookObject*)bookObject
{
    return [self.locallySavedObjectIDs containsObject:bookObject.parseID];
}

- (void)fetchSavedBooksObjectIDs
{
    PFQuery *bookQuery = [PFQuery queryWithClassName:@"Booklove"];
    [bookQuery fromLocalDatastore];
    [bookQuery selectKeys:@[@"objectId"]];
    [bookQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (PFObject *object in objects) {
            [tempArray addObject:object.objectId];
        }
        self.locallySavedObjectIDs = [tempArray mutableCopy];
    }];
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
