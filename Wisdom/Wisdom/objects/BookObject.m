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
        self.author = parseObject[@"Author"];
        self.bookDescription = parseObject[@"description_long"];
        self.bookTitle = parseObject[@"title"];
        self.sentence = parseObject[@"description_short"];

        self.imageURL = parseObject[@"coverimage"];

        self.linkURL = parseObject[@"purchaselink"];
        self.category = parseObject[@"Category"];
        self.price = parseObject[@"Price"];
        self.recommendedAt = parseObject[@"createdAt"];
        self.bookYear = parseObject[@"Year"];
        self.parseID = parseObject.objectId;

        NSString *recommendedByName = parseObject[@"rcmnded_name"];
        NSString *recommendedByImage = parseObject[@"rcmnded_img"];
        self.recommendedByUser = [[RecommendedByUser alloc] initWithName:recommendedByName andURL:recommendedByImage];
    }
    return self;
}

- (PFObject*)convertToParseObject
{
    PFObject *parseBook = [PFObject objectWithClassName:@"Booklove"];
    parseBook[@"Author"] = self.author ? self.author : @"";
    parseBook[@"description_long"] = self.bookDescription ? self.bookDescription : @"";
    parseBook[@"title"] = self.bookTitle ? self.bookTitle : @"";
    parseBook[@"coverimage"] = self.imageURL ? self.imageURL : @"";
    parseBook[@"purchaselink"] = self.linkURL ? self.linkURL : @"";
    parseBook[@"Price"] = self.price ? self.price : 0;
    parseBook[@"createdAt"] = self.recommendedAt ? self.recommendedAt : @"";
    parseBook[@"Year"] = self.bookYear ? self.bookYear : 0;
    parseBook[@"description_short"] = self.sentence ? self.sentence : @"";
    parseBook[@"Category"] = self.category ? self.category : @"";
    parseBook.objectId = self.parseID;

    if (![self.recommendedByUser isEmpty]) {
        parseBook[@"rcmnded_img"] = self.recommendedByUser.imageURL ? self.recommendedByUser.imageURL : @"";
        parseBook[@"rcmnded_name"] = self.recommendedByUser.name ? self.recommendedByUser.name : @"";
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
