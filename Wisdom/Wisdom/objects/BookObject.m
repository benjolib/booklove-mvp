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

- (PFObject*)convertToParseObject
{
    PFObject *parseBook = [PFObject objectWithClassName:@"books"];
    parseBook[@"author"] = self.author ? self.author : @"";
    parseBook[@"description"] = self.bookDescription ? self.bookDescription : @"";
    parseBook[@"title"] = self.bookTitle ? self.bookTitle : @"";
    parseBook[@"coverImage"] = self.imageURL ? self.imageURL : @"";
    parseBook[@"purchaseLink"] = self.linkURL ? self.linkURL : @"";
    parseBook[@"price"] = self.price ? self.price : 0;
    parseBook[@"recommendedAt"] = self.recommendedAt ? self.recommendedAt : @"";
    parseBook[@"year"] = self.bookYear ? self.bookYear : 0;
    parseBook[@"sentence"] = self.sentence ? self.sentence : @"";
    parseBook.objectId = self.parseID;

    if (![self.recommendedByUser isEmpty]) {
        parseBook[@"recommendedBy"] = @{@"name": self.recommendedByUser.name, @"image": self.recommendedByUser.imageURL};
    }
    return parseBook;
}

- (BOOL)isRecommended
{
    if (![self.recommendedByUser isEmpty]) {
        return YES;
    }

    return NO;
}

@end
