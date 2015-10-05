//
//  BookGenre.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BookGenre.h"

@implementation BookGenre

+ (BookGenre*)bookGenreWithName:(NSString*)name andRating:(NSInteger)rating
{
    return [[BookGenre alloc] initWithName:name andRating:rating];
}

- (instancetype)initWithName:(NSString*)name andRating:(NSInteger)rating
{
    self = [super init];
    if (self) {
        self.genreName = name;
        self.selectedRating = rating;
    }
    return self;
}

@end
