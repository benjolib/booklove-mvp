//
//  BookObject.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 28/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BaseImageModel.h"
#import "RecommendedByUser.h"

@class PFObject;

@interface BookObject : BaseImageModel

@property (nonatomic, copy) NSString *parseID;

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *bookDescription;
@property (nonatomic, copy) NSString *linkURL;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSDate *recommendedAt;
@property (nonatomic, copy) NSString *bookTitle;
@property (nonatomic, copy) NSString *sentence;
@property (nonatomic, strong) NSNumber *bookYear;
@property (nonatomic, strong) RecommendedByUser *recommendedByUser;
// needs category

- (instancetype)initWithParseObject:(PFObject*)parseObject;

+ (BookObject*)bookObjectWithParse:(PFObject*)parseObject;

- (BOOL)isRecommended;

@end
