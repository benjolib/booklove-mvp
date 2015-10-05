//
//  BookGenre.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookGenre : NSObject

@property (nonatomic, copy) NSString *genreName;
@property (nonatomic) NSInteger selectedRating;

+ (BookGenre*)bookGenreWithName:(NSString*)name andRating:(NSInteger)rating;

@end
