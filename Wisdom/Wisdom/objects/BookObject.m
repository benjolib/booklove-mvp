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
        self.sentence = parseObject[@"sentence"];

        self.imageURL = parseObject[@"coverImage"];

        self.linkURL = parseObject[@"purchaseLink"];
        self.price = parseObject[@"price"];
        self.recommendedAt = parseObject[@"recommendedAt"];
        self.bookYear = parseObject[@"year"];
        self.sentence = parseObject[@"sentence"];
        self.parseID = parseObject.objectId;

        NSDictionary *recommendedBy = parseObject[@"recommendedBy"];
        self.recommendedByUser = [[RecommendedByUser alloc] initWithName:recommendedBy[@"name"] andURL:recommendedBy[@"image"]];
    }
    return self;
}

- (BOOL)isRecommended
{
    if (![self.recommendedByUser isEmpty]) {
        return YES;
    }

    return NO;
}

@end
