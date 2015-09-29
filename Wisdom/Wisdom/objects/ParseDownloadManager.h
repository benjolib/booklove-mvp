//
//  ParseDownloadManager.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"

@interface ParseDownloadManager : NSObject

- (void)downloadQuotes;
- (void)downloadCollectionsWithCompletionBlock:(void (^)(NSArray *collections, NSString *errorMessage))completionBlock;

@end
