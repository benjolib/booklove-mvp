//
//  BookCollectionObject.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BaseImageModel.h"

@class PFObject, PFRelation;

@interface BookCollectionObject : BaseImageModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *objectID;
@property (nonatomic, copy) NSString *collectionID;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, strong) PFRelation *booksRelation;

- (instancetype)initWithParseObject:(PFObject*)parseObject;

+ (BookCollectionObject*)collectionObjectWithParse:(PFObject*)parseObject;

- (NSString*)author;

@end
