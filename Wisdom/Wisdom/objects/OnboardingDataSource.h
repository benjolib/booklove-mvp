//
//  OnboardingDataSource.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 23/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OnboardingViewController.h"

@interface OnboardingDataSource : NSObject

- (void)setRating:(NSInteger)ratingNumber forCategory:(OnboardingCategory)category;

- (NSArray*)imagesArrayForOnboardingCategory:(OnboardingCategory)category;

@end
