//
//  RecommendedByUser.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "RecommendedByUser.h"

@implementation RecommendedByUser

- (instancetype)initWithName:(NSString*)name andURL:(NSString*)imageURL
{
    self = [super init];
    if (self) {
        self.name = name;
        self.imageURL = imageURL;
    }
    return self;
}

- (BOOL)isEmpty
{
    return _name.length == 0 || self.imageURL.length == 0;
}

- (NSString*)name
{
    return [NSString stringWithFormat:@"Recommended by: %@", _name];
}

@end
