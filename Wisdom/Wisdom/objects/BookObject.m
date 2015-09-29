//
//  BookObject.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 28/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BookObject.h"
#import "PFObject.h"
#import "PFFile.h"

@implementation BookObject

+ (BookObject*)bookObjectWithParse:(PFObject*)parseObject
{
    return [[BookObject alloc] initWithParseObject:parseObject];
}

- (instancetype)initWithParseObject:(PFObject*)parseObject
{
    self = [super init];
    if (self) {
        self.author = parseObject[@"author"];
        self.bookDescription = parseObject[@"description"];
        self.bookTitle = parseObject[@"title"];

        PFFile *imageFile = parseObject[@"image"];
        self.imageURL = imageFile.url;

        self.linkURL = parseObject[@"purchaseLink"];
        self.price = parseObject[@"price"];
        self.recommendedAt = parseObject[@"recommendedAt"];
        self.bookYear = parseObject[@"year"];
        self.sentence = parseObject[@"sentence"];
        self.parseID = parseObject.objectId;
    }
    return self;
}

@end
