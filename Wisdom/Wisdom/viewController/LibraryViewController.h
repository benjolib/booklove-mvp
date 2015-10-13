//
//  LibraryViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ImageDownloadBaseViewController.h"

@interface LibraryViewController : ImageDownloadBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *emptyView;

- (IBAction)bookmarkButtonPressed:(UIButton*)button;
- (IBAction)buyButtonPressed:(UIButton*)button;

@end
