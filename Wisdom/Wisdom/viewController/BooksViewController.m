//
//  BooksViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "BooksViewController.h"
#import "BooksCollectionViewCell.h"
#import "BookCollectionObject.h"
#import "Parse.h"
#import "BookObject.h"
#import "LoadingImageView.h"
#import "ParseDownloadManager.h"
#import "BooksFlowLayout.h"
#import "BookGenre.h"
#import <Haneke/UIImageView+Haneke.h>
#import "AppDelegate.h"
#import "MainContainerViewController.h"

#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.9, 0.9)
#define ANIMATION_SPEED 0.2

@interface BooksViewController ()
@property (nonatomic, strong) NSArray *booksArray;
@property (nonatomic, strong) ParseDownloadManager *downloadManager;
@property (nonatomic, strong) BooksFlowLayout *flowLayout;
@property (nonatomic) BOOL isfirstTimeTransform;
@end

@implementation BooksViewController

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadBooksForDate:(NSDate*)date
{
    self.selectedDate = date;
    [self loadBooks];
}

- (void)loadBooksForGenre:(BookGenre*)genre
{
    self.selectedGenre = genre;
    [self loadBooks];
}

- (void)loadBooks
{
    self.downloadManager = [[ParseDownloadManager alloc] init];
    [self.downloadManager downloadBooksForDate:self.selectedDate genre:self.selectedGenre withCompletionBlock:^(NSArray *books, NSString *errorMessage) {
        [self.collectionView hideLoadingIndicator];
        if (books) {
            self.booksArray = [books copy];
        } else {
            if (errorMessage) {

            }
        }
        [self.collectionView reloadData];
    }];
}

- (BookGenre*)selectedGenre
{
    if (!_selectedGenre) {
        _selectedGenre = [[BookGenre alloc] init];
        _selectedGenre.genreName = [GeneralSettings favoriteCategory];
    }

    return _selectedGenre;
}

- (NSMutableArray*)objectsToDisplay
{
    return [self.booksArray mutableCopy];
}

- (IBAction)bookFlipButtonPressed:(UIButton*)button
{
    UIView *aSuperview = [button superview];
    while (![aSuperview isKindOfClass:[BooksCollectionViewCell class]]) {
        aSuperview = [aSuperview superview];
    }

    BooksCollectionViewCell *cell = (BooksCollectionViewCell*)aSuperview;

    [cell flipToShowNormalView];
}

- (IBAction)bookmarkButtonPressed:(UIButton*)button
{

}

#pragma mark - collectionView methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BooksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    BookObject *book = self.objectsToDisplay[indexPath.row];

    cell.titleLabel.text = book.bookTitle;

    if ([book isRecommended]) {
        cell.recommendWrapperView.alpha = 1.0;
        cell.recommendSeparatorLineView.alpha = 1.0;
        cell.recommendedByView.titleLabel.text = book.recommendedByUser.name;
        [cell.recommendedByView.recommendedView hnk_setImageFromURL:[NSURL URLWithString:book.recommendedByUser.imageURL]];
    } else {
        cell.recommendWrapperView.alpha = 0.0;
        cell.recommendSeparatorLineView.alpha = 0.0;
    }

    cell.subtitleLabel.text = book.sentence;
    [cell.bookCoverImageView hnk_setImageFromURL:[NSURL URLWithString:book.imageURL]];

    // TODO: check if books is saved to local datastore, if YES, show it with the bookmark icon
    

//    if (indexPath.row == 0 && self.isfirstTimeTransform) { // make a bool and set YES initially, this check will prevent fist load transform
//        self.isfirstTimeTransform = NO;
//    }else{
//        cell.transform = TRANSFORM_CELL_VALUE; // the new cell will always be transform and without animation
//    }

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.objectsToDisplay.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BooksCollectionViewCell *cell = (BooksCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

    if (!cell.cellFlipped) {
        BookObject *book = self.objectsToDisplay[indexPath.row];
        [cell flipToShowDetailViewWithBookObject:book];
    }
}

- (void)loadImagesForVisibleRows
{
    NSArray *visibleRows = [self.collectionView indexPathsForVisibleItems];
    for (NSIndexPath *indexpath in visibleRows) {
        if (indexpath.row < [self objectsToDisplay].count )
        {
            BaseImageModel *object = self.objectsToDisplay[indexpath.row];
            if (!object.image) {
                [self startImageDownloadForObject:object atIndexPath:indexpath];
            }
        }
    }
}

- (void)updateTableViewCellAtIndexPath:(NSIndexPath *)indexPath image:(UIImage *)image
{
    BooksCollectionViewCell *cell = (BooksCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        BookObject *book = self.objectsToDisplay[indexPath.row];
        book.image = image;
        cell.bookCoverImageView.image = image;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    *targetContentOffset = scrollView.contentOffset; // set acceleration to 0.0
    float pageWidth = (float)self.collectionView.bounds.size.width - 40;
    int minSpace = 20;

    int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5; // cell width + min spacing for lines
    if (cellToSwipe < 0) {
        cellToSwipe = 0;
    } else if (cellToSwipe >= self.booksArray.count) {
        cellToSwipe = self.booksArray.count - 1;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    float pageWidth = CGRectGetWidth(self.collectionView.frame) - 40.0; // width + space
//
//    float currentOffset = scrollView.contentOffset.x;
//    float targetOffset = targetContentOffset->x;
//    float newTargetOffset = 0;
//
//    if (targetOffset > currentOffset)
//        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
//    else
//        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
//
//    if (newTargetOffset < 0)
//        newTargetOffset = 0;
//    else if (newTargetOffset > scrollView.contentSize.width)
//        newTargetOffset = scrollView.contentSize.width;
//
//    targetContentOffset->x = currentOffset;
//    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
//
//    int index = newTargetOffset / pageWidth;
//
//    if (index == 0) { // If first index
//        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//
//        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
//            cell.transform = CGAffineTransformIdentity;
//        }];
//        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1 inSection:0]];
//        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
//            cell.transform = TRANSFORM_CELL_VALUE;
//        }];
//    }else{
//        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
//            cell.transform = CGAffineTransformIdentity;
//        }];
//
//        index --; // left
//        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
//            cell.transform = TRANSFORM_CELL_VALUE;
//        }];
//
//        index ++;
//        index ++; // right
//        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
//            cell.transform = TRANSFORM_CELL_VALUE;
//        }];
//    }
//}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];
    self.isfirstTimeTransform = YES;

    self.flowLayout = [[BooksFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = self.flowLayout;

    self.recommendedByLabel.text = @"";
    self.collectionTitleLabel.text = @"";

    [self.collectionView showLoadingIndicator];

    // opening from a collection
    if (self.selectedCollectionObject) {
        // load the relation object's books
        if (!self.downloadManager) {
            self.downloadManager = [[ParseDownloadManager alloc] init];
        }

        [self.downloadManager downloadBooksForCollectionID:self.selectedCollectionObject.objectID withCompletionBlock:^(NSArray *books, NSString *errorMessage) {
            [self.collectionView hideLoadingIndicator];
            if (books) {
                self.booksArray = [books copy];
            } else {
                if (errorMessage) {
                    // handle error here
                }
            }

            self.backButton.hidden = NO;
            self.recommendedByLabel.hidden = NO;
            self.collectionTitleLabel.hidden = NO;

            self.collectionTitleLabel.text = self.selectedCollectionObject.title;
            self.recommendedByLabel.text = [self.selectedCollectionObject author];
            
            [self.collectionView reloadData];
        }];
    }
    else
    {
        if (self.bookToDiplay) { // displayed from library
            [self.collectionView hideLoadingIndicator];
            self.booksArray = @[self.bookToDiplay];
            self.backButton.hidden = NO;
            self.recommendedByLabel.hidden = YES;
            self.collectionTitleLabel.hidden = YES;
            [self.collectionView reloadData];
        } else {
            [self loadBooks];
            self.backButton.hidden = YES;
            self.recommendedByLabel.hidden = YES;
            self.collectionTitleLabel.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
