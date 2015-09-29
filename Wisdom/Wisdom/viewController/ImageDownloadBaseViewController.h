//
//  ImageDownloadBaseViewController.h
//  SoundLove
//
//  Created by Sztanyi Szabolcs on 31/07/15.
//  Copyright (c) 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseImageModel;

@interface ImageDownloadBaseViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (NSArray*)objectsToDisplay;

- (void)startImageDownloadForObject:(BaseImageModel*)object atIndexPath:(NSIndexPath*)indexPath;
- (void)updateTableViewCellAtIndexPath:(NSIndexPath*)indexPath image:(UIImage*)image;

- (void)cancelAllImageDownloads;
- (void)loadImagesForVisibleRows;

@end
