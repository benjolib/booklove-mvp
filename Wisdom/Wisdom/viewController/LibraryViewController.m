//
//  LibraryViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "LibraryViewController.h"
#import "LibraryTableViewCell.h"
#import "ParseLocalStoreManager.h"
#import "AppDelegate.h"
#import "BookObject.h"

@interface LibraryViewController ()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) NSMutableArray *savedBooksArray;
@property (nonatomic, strong) ParseLocalStoreManager *storageManager;
@end

@implementation LibraryViewController

- (void)loadSavedBooks
{
    [self.storageManager loadLibraryBooksWithCompletionBlock:^(NSArray *booksArray, NSString *errorMessage) {
        if (errorMessage) {

        } else {
            self.savedBooksArray = [booksArray mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

- (ParseLocalStoreManager*)storageManager
{
    if (!_storageManager) {
        _storageManager = [[ParseLocalStoreManager alloc] init];
    }

    return _storageManager;
}

- (IBAction)bookmarkButtonPressed:(UIButton*)button
{
    UIView *aSuperview = [button superview];
    while (![aSuperview isKindOfClass:[LibraryTableViewCell class]]) {
        aSuperview = [aSuperview superview];
    }

    LibraryTableViewCell *cell = (LibraryTableViewCell*)aSuperview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BookObject *object = self.savedBooksArray[indexPath.row];

    // remove object
    [self removeObject:object atIndexPath:indexPath];
}

- (IBAction)buyButtonPressed:(UIButton*)button
{
    UIView *aSuperview = [button superview];
    while (![aSuperview isKindOfClass:[LibraryTableViewCell class]]) {
        aSuperview = [aSuperview superview];
    }

    LibraryTableViewCell *cell = (LibraryTableViewCell*)aSuperview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BookObject *object = self.savedBooksArray[indexPath.row];

    // add URL
    [self openWebsiteWithURL:[NSURL URLWithString:object.linkURL]];
}

- (void)openWebsiteWithURL:(NSURL*)url
{
    [[UIApplication sharedApplication] openURL:url];
}

- (void)removeObject:(BookObject*)object atIndexPath:(NSIndexPath*)indexPath
{
    [self.storageManager removeObjectFromLocalStore:object completionBlock:^(BOOL succeeded, NSString *errorMessage) {
        if (succeeded) {
            [self.savedBooksArray removeObject:object];

            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        } else {
            // handle error here
        }
    }];
}

#pragma mark - tableView methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.savedBooksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    BookObject *book = self.savedBooksArray[indexPath.row];

    cell.bookAuthorLabel.text = book.author;
    cell.bookTitleLabel.text = book.bookTitle;
    cell.categoryLabel.text = @"Crime and stuff";

    if (book.image) {
        cell.bookCoverImageView.image = book.image;
    } else {
        if (!tableView.dragging && !tableView.decelerating) {
            [super startImageDownloadForObject:book atIndexPath:indexPath];
        }
    }

    return cell;
}

- (void)updateTableViewCellAtIndexPath:(NSIndexPath *)indexPath image:(UIImage *)image
{
    LibraryTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        BookObject *book = self.savedBooksArray[indexPath.row];
        book.image = image;
        cell.bookCoverImageView.image = image;
    }
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor backgroundColor];
    [self loadSavedBooks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

@end
