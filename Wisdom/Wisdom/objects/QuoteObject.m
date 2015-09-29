//
//  QuoteObject.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "QuoteObject.h"
#import "PFObject.h"

@implementation QuoteObject

- (instancetype)initWithPFObject:(PFObject*)parseObject
{
    self = [super init];
    if (self) {
        self.quote = parseObject[@"quote"];
        self.author = parseObject[@"statedBy"];
    }
    return self;
}

@end
