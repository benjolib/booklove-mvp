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
#import "BooksViewController.h"
#import <Haneke/UIImageView+Haneke.h>

@interface LibraryViewController ()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) NSMutableArray *savedBooksArray;
@end

@implementation LibraryViewController

- (void)loadSavedBooks
{
    [[ParseLocalStoreManager sharedManager] loadLibraryBooksWithCompletionBlock:^(NSArray *booksArray, NSString *errorMessage) {
        if (errorMessage) {

        } else {
            self.savedBooksArray = [booksArray mutableCopy];
            [self.tableView reloadData];
            [self checkToShowEmptyView];
        }
    }];
}

- (void)checkToShowEmptyView
{
    if ([self objectsToDisplay].count > 0) {
        self.emptyView.hidden = YES;
    } else {
        self.emptyView.hidden = NO;
    }
}

- (NSMutableArray *)objectsToDisplay
{
    return self.savedBooksArray;
}

- (IBAction)bookmarkButtonPressed:(UIButton*)button
{
    UIView *aSuperview = [button superview];
    while (![aSuperview isKindOfClass:[LibraryTableViewCell class]]) {
        aSuperview = [aSuperview superview];
    }

    LibraryTableViewCell *cell = (LibraryTableViewCell*)aSuperview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BookObject *object = self.objectsToDisplay[indexPath.row];

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
    BookObject *object = self.objectsToDisplay[indexPath.row];

    // add URL
    [self openWebsiteWithURL:[NSURL URLWithString:object.linkURL]];
}

- (void)openWebsiteWithURL:(NSURL*)url
{
    [TRACKER trackLibraryBuyButton];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)removeObject:(BookObject*)object atIndexPath:(NSIndexPath*)indexPath
{
    [TRACKER trackLibraryBookmarkRemove];

    [[ParseLocalStoreManager sharedManager] removeObjectFromLocalStore:object];
    [self.savedBooksArray removeObject:object];

    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];

    [self checkToShowEmptyView];
}

#pragma mark - tableView methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objectsToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    BookObject *book = self.objectsToDisplay[indexPath.row];

    cell.bookAuthorLabel.text = book.author;
    cell.bookTitleLabel.text = book.bookTitle;
    cell.categoryLabel.text = book.category;

    [cell.bookCoverImageView hnk_setImageFromURL:[NSURL URLWithString:book.imageURL]];

    return cell;
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor backgroundColor];
    self.emptyView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadSavedBooks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showBookDetail"])
    {
        if ([sender isKindOfClass:[LibraryTableViewCell class]])
        {
            [TRACKER trackLibraryBookFlipped];
            LibraryTableViewCell *cell = (LibraryTableViewCell*)sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

            BooksViewController *booksViewController = segue.destinationViewController;
            booksViewController.loadLibraryBooks = YES;
            booksViewController.booksArray = self.objectsToDisplay;
            booksViewController.selectedIndexOfBook = indexPath.row;
        }
    }
}

@end
