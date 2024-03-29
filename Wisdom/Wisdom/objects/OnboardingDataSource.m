//
//  OnboardingDataSource.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 23/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "OnboardingDataSource.h"

@interface OnboardingDataSource ()
@property (nonatomic, strong) NSMutableDictionary *ratingsDictionary;
@end

@implementation OnboardingDataSource

- (NSArray*)imagesArrayForOnboardingCategory:(OnboardingCategory)category
{
    NSArray *imagesArray = nil;

    switch (category) {
        case OnboardingCategoryCrime: {
            UIImage *im1 = [UIImage imageNamed:@"c1"];
            UIImage *im2 = [UIImage imageNamed:@"c2"];
            UIImage *im3 = [UIImage imageNamed:@"c3"];
            UIImage *im4 = [UIImage imageNamed:@"c4"];
            UIImage *im5 = [UIImage imageNamed:@"c5"];
            UIImage *im6 = [UIImage imageNamed:@"c6"];
            UIImage *im7 = [UIImage imageNamed:@"c7"];
            UIImage *im8 = [UIImage imageNamed:@"c8"];

            UIImage *star = [UIImage imageNamed:@"star"];

            imagesArray = @[[UIImage imageNamed:@"c1"], [UIImage imageNamed:@"c2"], [UIImage imageNamed:@"c3"],
                            [UIImage imageNamed:@"c4"], [UIImage imageNamed:@"c5"], [UIImage imageNamed:@"c6"],
                            [UIImage imageNamed:@"c7"], [UIImage imageNamed:@"c8"]];
            break;
        }

        case OnboardingCategoryClassic:
            imagesArray = @[[UIImage imageNamed:@"cl1"], [UIImage imageNamed:@"cl2"], [UIImage imageNamed:@"cl3"],
                            [UIImage imageNamed:@"cl4"], [UIImage imageNamed:@"cl5"], [UIImage imageNamed:@"cl6"],
                            [UIImage imageNamed:@"cl7"], [UIImage imageNamed:@"cl8"]];
            break;
        case OnboardingCategoryBiography:
            imagesArray = @[[UIImage imageNamed:@"b1"], [UIImage imageNamed:@"b2"], [UIImage imageNamed:@"b3"],
                            [UIImage imageNamed:@"b4"], [UIImage imageNamed:@"b5"], [UIImage imageNamed:@"b6"],
                            [UIImage imageNamed:@"b7"], [UIImage imageNamed:@"b8"]];
            break;
        case OnboardingCategoryScience:
            imagesArray = @[[UIImage imageNamed:@"s1"], [UIImage imageNamed:@"s2"], [UIImage imageNamed:@"s3"],
                            [UIImage imageNamed:@"s4"], [UIImage imageNamed:@"s5"], [UIImage imageNamed:@"s6"],
                            [UIImage imageNamed:@"s7"], [UIImage imageNamed:@"s8"]];
            break;
        case OnboardingCategoryTravel:
            imagesArray = @[[UIImage imageNamed:@"t1"], [UIImage imageNamed:@"t2"], [UIImage imageNamed:@"t3"],
                            [UIImage imageNamed:@"t4"], [UIImage imageNamed:@"t5"], [UIImage imageNamed:@"t6"],
                            [UIImage imageNamed:@"t7"], [UIImage imageNamed:@"t8"]];
            break;
        default:
            break;
    }

    return imagesArray;
}

- (void)setRating:(NSInteger)ratingNumber forCategory:(OnboardingCategory)category
{
    switch (category) {
        case OnboardingCategoryCrime:
//            [self.ratingsDictionary setObject:@(ratingNumber) forKey:category];
            break;
        case OnboardingCategoryClassic:

            break;
        case OnboardingCategoryBiography:

            break;
        case OnboardingCategoryScience:

            break;
        case OnboardingCategoryTravel:
            
            break;
        default:
            break;
    }
}

- (NSMutableDictionary*)ratingsDictionary
{
    if (!_ratingsDictionary) {
        _ratingsDictionary = [NSMutableDictionary dictionary];
    }
    return _ratingsDictionary;
}

@end
