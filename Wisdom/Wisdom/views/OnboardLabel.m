//
//  OnboardLabel.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 23/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "OnboardLabel.h"

@implementation OnboardLabel

- (void)setActive:(BOOL)active
{
    if (active) {
        self.textColor = [UIColor redSelectionColor];
    } else {
        self.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    }
}

@end
