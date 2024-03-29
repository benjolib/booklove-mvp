//
//  QuotesViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "QuotesViewController.h"
#import "ParseLocalStoreManager.h"
#import "QuoteObject.h"
#import "AppDelegate.h"

@implementation QuotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_async(dispatch_queue_create("getting_quote_object", NULL), ^{
        ParseLocalStoreManager *parseLocalStoreManager = [[ParseLocalStoreManager alloc] init];
        [parseLocalStoreManager loadRandomQuoteWithCompletionBlock:^(QuoteObject *quote) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (quote) {
                    [self updateViewWithQuote:quote];
                } else {
                    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                    [appDelegate hideQuotesScreen];
                }
            });
        }];
    });
}

- (void)updateViewWithQuote:(QuoteObject*)quote
{
    self.quoteLabel.text = quote.quote;
    self.authorLabel.text = quote.author;

    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [appDelegate hideQuotesScreen];
        }];
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.quoteLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.quoteLabel.frame);

    [self.view layoutIfNeeded];
}

@end
