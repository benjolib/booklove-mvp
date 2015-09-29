//
//  BookCollectionObject.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BookCollectionObject.h"
#import "PFObject.h"

@implementation BookCollectionObject

- (instancetype)initWithParseObject:(PFObject*)parseObject
{
    self = [super init];
    if (self) {
        self.title = parseObject[@"title"];
        self.collectionID = parseObject[@"collectionId"];
        self.objectID = [parseObject objectId];
        self.imageURL = parseObject[@"imageUrl"];

        self.booksRelation = [parseObject relationForKey:@"books"];
    }
    return self;
}

+ (BookCollectionObject*)collectionObjectWithParse:(PFObject*)parseObject
{
    return [[BookCollectionObject alloc] initWithParseObject:parseObject];
}

@end
