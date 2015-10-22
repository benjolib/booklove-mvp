//
//  BookCollectionObject.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BookCollectionObject.h"
#import "PFObject.h"
#import "PFFile.h"

@implementation BookCollectionObject

- (instancetype)initWithParseObject:(PFObject*)parseObject
{
    self = [super init];
    if (self) {
        self.title = parseObject[@"title"];
        self.collectionID = parseObject[@"collectionId"];
        self.objectID = [parseObject objectId];
        self.author = parseObject[@"author"];

        PFFile *imageFile = parseObject[@"imageFile"];
        self.imageURL = imageFile.url;
    }
    return self;
}

+ (BookCollectionObject*)collectionObjectWithParse:(PFObject*)parseObject
{
    return [[BookCollectionObject alloc] initWithParseObject:parseObject];
}

- (NSString*)author
{
    if (_author.length != 0) {
        return [NSString stringWithFormat:@"%@'%@ %@", _author, [self stringToShowAfterAuthorName], @"favorites"];
    } else {
        return @"";
    }
}

- (NSString*)stringToShowAfterAuthorName
{
    if (_author.length != 0) {
        if ([[_author substringFromIndex:_author.length - 1] isEqualToString:@"s"]) {
            return @"";
        } else {
            return @"s";
        }
    } else {
        return @"";
    }
}

@end
