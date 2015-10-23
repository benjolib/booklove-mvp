//
//  ParseDownloadManager.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"
#import "BookGenre.h"

@interface ParseDownloadManager : NSObject

#pragma mark - download methods
- (void)downloadBooksForDate:(NSDate*)date genre:(BookGenre*)bookGenre withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock;
- (void)downloadAllBooksForDate:(NSDate*)date genre:(BookGenre*)currentBookGenre withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock;

- (void)downloadBooksForCollectionID:(NSString*)collectionID withCompletionBlock:(void (^)(NSArray *books, NSString *errorMessage))completionBlock;

- (void)downloadQuotes;
- (void)downloadCollectionsWithCompletionBlock:(void (^)(NSArray *collections, NSString *errorMessage))completionBlock;

@end
