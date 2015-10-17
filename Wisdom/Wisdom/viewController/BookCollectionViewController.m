//
//  BookCollectionViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BookCollectionViewController.h"
#import "BookCollectionTableViewCell.h"
#import "ParseDownloadManager.h"
#import "BookCollectionObject.h"
#import "BooksViewController.h"

@interface BookCollectionViewController ()
@property (nonatomic, strong) NSArray *collectionsArray;
@property (nonatomic, strong) ParseDownloadManager *parseDownloadManager;
@property (nonatomic, strong) UIRefreshControl *refreshController;
@end

@implementation BookCollectionViewController

- (NSMutableArray*)objectsToDisplay
{
    return [self.collectionsArray mutableCopy];
}

#pragma mark - tableView methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collectionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell"];

    BookCollectionObject *collection = self.objectsToDisplay[indexPath.row];

    cell.collectionNameLabel.text = collection.title;

    if (collection.author) {
        // the user's name somehow
        cell.titleLabel.text = [collection author];
    } else {
        cell.titleLabel.text = @"";
    }

    if (collection.image) {
        cell.coverImageView.image = collection.image;
    } else {
        if (!tableView.dragging && !tableView.decelerating) {
            [super startImageDownloadForObject:collection atIndexPath:indexPath];
        }
    }

    return cell;
}

- (void)updateTableViewCellAtIndexPath:(NSIndexPath *)indexPath image:(UIImage *)image
{
    BookCollectionTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        BookCollectionObject *collection = self.collectionsArray[indexPath.row];
        collection.image = image;
        cell.coverImageView.image = image;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userSelectedCollection"])
    {
        if ([sender isKindOfClass:[BookCollectionTableViewCell class]])
        {
            [TRACKER trackCollectionSelected];

            NSIndexPath *indexPath = [self.tableView indexPathForCell:(BookCollectionTableViewCell*)sender];

            BookCollectionObject *collection = self.collectionsArray[indexPath.row];

            // open this thingy
            BooksViewController *booksViewController = segue.destinationViewController;
            booksViewController.selectedCollectionObject = collection;
        }
    }
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView showLoadingIndicator];

    self.refreshController = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0, -50.0, CGRectGetWidth(self.view.frame), 50.0)];
    [self.tableView addSubview:self.refreshController];
    self.refreshController.tintColor = [UIColor globalGreenColor];
    [self.refreshController addTarget:self action:@selector(downloadCollections) forControlEvents:UIControlEventValueChanged];

    [self downloadCollections];
}

- (void)downloadCollections
{
    [self.refreshController beginRefreshing];

    self.parseDownloadManager = [[ParseDownloadManager alloc] init];
    [self.parseDownloadManager downloadCollectionsWithCompletionBlock:^(NSArray *collections, NSString *errorMessage) {
        [self.tableView hideLoadingIndicator];
        [self.refreshController endRefreshing];

        if (collections) {
            self.collectionsArray = [collections copy];
        } else {
            if (errorMessage) {
                // handle error somehow
            }
        }

        [self.tableView reloadData];
    }];
}

@end
