//
//  ParseLocalStoreManager.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"

@class BookObject, QuoteObject;

@interface ParseLocalStoreManager : NSObject

+ (instancetype)sharedManager;
- (void)fetchSavedBooksObjectIDs;

- (void)loadLibraryBooksWithCompletionBlock:(void (^)(NSArray *booksArray, NSString *errorMessage))completionBlock;
- (void)loadRandomQuoteWithCompletionBlock:(void (^)(QuoteObject *quote))completionBlock;

- (void)storeBookObjectLocally:(BookObject*)book;
- (void)removeObjectFromLocalStore:(BookObject*)bookObject;

- (BOOL)isBookSavedLocally:(BookObject*)bookObject;

@end
