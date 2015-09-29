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

@interface BooksViewController ()
@property (nonatomic, strong) NSArray *booksArray;
@end

@implementation BooksViewController

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadBooksForDate:(NSDate*)date
{
    self.selectedDate = date;

}

- (void)loadBooksForGenre:(NSString*)genreString
{
    self.selectedGenre = genreString;
    
}

- (NSArray*)objectsToDisplay
{
    return self.booksArray;
}

#pragma mark - collectionView methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BooksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    BookObject *book = self.objectsToDisplay[indexPath.row];

    cell.titleLabel.text = book.bookTitle;

    if (book.recommendedBy) {

    } else {
        cell.recommendedByView.hidden = YES;
    }

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.objectsToDisplay.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame) - 40.0, CGRectGetHeight(collectionView.frame) - 60.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
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

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];

    if (self.selectedCollectionObject) {
        // load the relation object's books
        PFRelation *booksRelation = self.selectedCollectionObject.booksRelation;
        [booksRelation.query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count > 0) {
                NSMutableArray *tempArray = [NSMutableArray array];
                for (PFObject *parseObject in objects) {
                    [tempArray addObject:[BookObject bookObjectWithParse:parseObject]];
                }
                self.booksArray = [tempArray copy];
            } else {
                if (error) {
                    // handle error here
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                self.backButton.hidden = NO;
                self.recommendedByLabel.hidden = NO;
                self.collectionTitleLabel.hidden = NO;

                self.collectionTitleLabel.text = self.selectedCollectionObject.title;
                [self.collectionView reloadData];
            });
        }];
    } else {
        self.backButton.hidden = YES;
        self.recommendedByLabel.hidden = YES;
        self.collectionTitleLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
