//
//  RecommendedByUser.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 01/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendedByUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithName:(NSString*)name andURL:(NSString*)imageURL;

- (BOOL)isEmpty;

- (NSString*)formattedName;

@end
