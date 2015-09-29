//
//  QuoteObject.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;

@interface QuoteObject : NSObject

@property (nonatomic, copy) NSString *quote;
@property (nonatomic, copy) NSString *author;

- (instancetype)initWithPFObject:(PFObject*)parseObject;

@end
