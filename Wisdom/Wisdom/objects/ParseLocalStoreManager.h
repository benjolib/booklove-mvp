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

- (void)loadLibraryBooksWithCompletionBlock:(void (^)(NSArray *booksArray, NSString *errorMessage))completionBlock;
- (void)loadRandomQuoteWithCompletionBlock:(void (^)(QuoteObject *quote))completionBlock;

- (void)storeParseObjectLocally:(PFObject*)parseObject;
- (void)removeObjectFromLocalStore:(BookObject*)parseObject completionBlock:(void (^)(BOOL succeeded, NSString *errorMessage))completionBlock;

- (BOOL)isObjectSavedLocally:(PFObject*)parseObject;

@end
