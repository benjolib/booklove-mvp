//
//  MainContainerViewController.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "MainContainerViewController.h"
#import "LibraryViewController.h"
#import "StoryboardManager.h"
#import "BookCollectionViewController.h"
#import "SelectionCollectionViewCell.h"
#import "MainContainerSelectionDatasource.h"
#import "BooksViewController.h"
#import "NSDate+Helper.h"
#import "OverlayTransitionManager.h"
#import "TabButton.h"
#import "AppDelegate.h"

@interface MainContainerViewController ()
@property (nonatomic) MenuItem currentMenuItem;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic) CGFloat defaultTopbarYOrigin;
@property (nonatomic, strong) MainContainerSelectionDatasource *selectionDatasource;
@property (nonatomic) MainContainerSelectedItem currentlySelectedItem;
@property (nonatomic, strong) OverlayTransitionManager *overlayTransitionManager;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation MainContainerViewController

- (IBAction)genreButtonPressed:(id)sender
{
    [TRACKER trackRecommendationGenre];

    [UIView animateWithDuration:0.2 animations:^{
        self.genreLabel.alpha = 0.4;
    } completion:^(BOOL finished) {
        self.genreLabel.alpha = 1.0;
    }];

    if (self.currentlySelectedItem == MainContainerSelectedItemGenre) {
        [self hideSelectionViewWithAnimation:YES];
    } else {
        if (self.selectionViewHeightConstraint.constant != 0) {
            self.currentlySelectedItem = MainContainerSelectedItemGenre;
            [self.selectionDatasource loadItemsForSelectedItem:MainContainerSelectedItemGenre];
            [self.selectionCollectionView reloadData];
        } else {
            [self openSelectionViewWithOption:MainContainerSelectedItemGenre];
        }
    }
}

- (IBAction)dateButtonPressed:(id)sender
{
    [TRACKER trackRecommendationDate];

    [UIView animateWithDuration:0.2 animations:^{
        self.dateLabel.alpha = 0.4;
    } completion:^(BOOL finished) {
        self.dateLabel.alpha = 1.0;
    }];

    if (self.currentlySelectedItem == MainContainerSelectedItemDate) {
        [self hideSelectionViewWithAnimation:YES];
    } else {
        if (self.selectionViewHeightConstraint.constant != 0) {
            self.currentlySelectedItem = MainContainerSelectedItemDate;
            [self.selectionDatasource loadItemsForSelectedItem:MainContainerSelectedItemDate];
            [self.selectionCollectionView reloadData];
        } else {
            [self openSelectionViewWithOption:MainContainerSelectedItemDate];
        }
    }
}

- (IBAction)donateButtonPressed:(id)sender
{
    [TRACKER trackSelectedDonationTab];

    // show donate view
    self.overlayTransitionManager = [[OverlayTransitionManager alloc] init];
    [self.overlayTransitionManager presentDonateViewOnViewController:self];
}

- (void)openSelectionViewWithOption:(MainContainerSelectedItem)selectedItem
{
    [self.selectionDatasource loadItemsForSelectedItem:selectedItem];

    self.currentlySelectedItem = selectedItem;
    [self openSelectionView];
}

- (void)openSelectionView
{
    self.selectionViewHeightConstraint.constant = CGRectGetHeight(self.containerView.frame) - 50.0;
    self.bottomYOriginConstraint.constant = -self.selectionViewHeightConstraint.constant;

    [self.selectionCollectionView reloadData];


    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideSelectionViewWithAnimation:(BOOL)animated
{
    self.selectionViewHeightConstraint.constant = 0.0;
    self.bottomYOriginConstraint.constant = 0.0;

    self.currentlySelectedItem = MainContainerSelectedItemNone;

    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.view layoutIfNeeded];
    }
}

#pragma mark - changing views
- (IBAction)collectionButtonPressed:(id)sender
{
    [TRACKER trackSelectedCollectionTab];

    [self hideSelectionViewWithAnimation:NO];

    self.buttonSelectionViewCenterConstraint.constant = -CGRectGetMaxX(self.libraryButton.frame)/3;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];

    [self changeToMenuItem:MenuItemCollection];
}

- (IBAction)booksButtonPressed:(id)sender
{
    [TRACKER trackSelectedBooksTab];

    self.buttonSelectionViewCenterConstraint.constant = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];

    [self changeToMenuItem:MenuItemBooks];
}

- (IBAction)libraryButtonPressed:(id)sender
{
    [TRACKER trackSelectedLibraryTab];

    [self hideSelectionViewWithAnimation:NO];

    self.buttonSelectionViewCenterConstraint.constant = CGRectGetMaxX(self.libraryButton.frame)/3;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];

    [self changeToMenuItem:MenuItemLibrary];
}

- (void)changeToMenuItem:(MenuItem)menuItem
{
    if (self.currentMenuItem == menuItem) {
        return;
    }

    self.currentMenuItem = menuItem;
    switch (menuItem) {
        case MenuItemNone:
            [self setTopBarVisible:YES];
            break;
        case MenuItemCollection: {
            [self setTopBarVisible:NO];

            id viewController = [self viewControllerAtMenuItem:MenuItemCollection];
            if (!viewController) {
                viewController = [StoryboardManager collectionNavigationController];
            }
            [self startTransitionToViewController:viewController];
            break;
        }
        case MenuItemBooks: {
            [self setTopBarVisible:YES];

            id viewController = [self viewControllerAtMenuItem:MenuItemBooks];
            if (!viewController) {
                viewController = [StoryboardManager booksViewController];
            }
            [self startTransitionToViewController:viewController];
            break;
        }
        case MenuItemLibrary: {
            [self setTopBarVisible:NO];

            id viewController = [self viewControllerAtMenuItem:MenuItemLibrary];
            if (!viewController) {
                viewController = [StoryboardManager libraryNavigationController];
            }
            [self startTransitionToViewController:viewController];
            break;
        }
        default:
            break;
    }
}

- (void)startTransitionToViewController:(UIViewController*)toDisplayViewController
{
    if (![self.childViewControllers containsObject:toDisplayViewController]) {
        [self addChildViewController:toDisplayViewController];
    }

    if (self.currentViewController) {
        [self transitionFromViewController:self.currentViewController
                          toViewController:toDisplayViewController
                                  duration:0.0
                                   options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionShowHideTransitionViews
                                animations:^{
                                    toDisplayViewController.view.frame = self.containerView.bounds;
                                }
                                completion:^(BOOL finished) {
                                    if (!toDisplayViewController.parentViewController) {
                                        [toDisplayViewController didMoveToParentViewController:self];
                                    }
                                    self.currentViewController = toDisplayViewController;
                                }];
    } else {
        self.currentViewController = toDisplayViewController;

        [self.currentViewController willMoveToParentViewController:self];
        self.currentViewController.view.frame = self.containerView.bounds;
        [self.containerView addSubview:self.currentViewController.view];

        [self.currentViewController didMoveToParentViewController:self];
    }
}

- (UIViewController*)viewControllerAtMenuItem:(MenuItem)menuItem
{
    UIViewController *viewControllerToLoad = nil;

    NSString *targetClassString = nil;
    switch (menuItem)
    {
        case MenuItemNone: {
            targetClassString = @"";
            break;
        }
        case MenuItemCollection: {
            targetClassString = @"CollectionsNavigationController";
            break;
        }
        case MenuItemBooks: {
            targetClassString = @"BooksViewController";
            break;
        }
        case MenuItemLibrary: {
            targetClassString = @"LibraryNavigationController";
            break;
        }
        default:
            break;
    }

    for (UIViewController *viewController in self.childViewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(targetClassString)]) {
            viewControllerToLoad = viewController;
            break;
        }
    }

    return viewControllerToLoad;
}

- (void)setTopBarVisible:(BOOL)visible
{
    if (visible) {
        if (self.topbarYOriginConstraint.constant != 0) {
            self.topbarYOriginConstraint.constant = 0.0;
            [self.view layoutIfNeeded];
        }
    } else {
        if (self.topbarYOriginConstraint.constant != -CGRectGetHeight(self.topbarView.frame)) {
            self.topbarYOriginConstraint.constant = -CGRectGetHeight(self.topbarView.frame);
            [self.view layoutIfNeeded];
        }
    }
}

#pragma mark - collectionView methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    id itemToDisplay = self.selectionDatasource.itemsToDisplay[indexPath.row];

    BooksViewController *booksViewController = (BooksViewController*)self.currentViewController;
    if (self.currentlySelectedItem == MainContainerSelectedItemDate)
    {
        NSDate *date = (NSDate*)itemToDisplay;
        cell.titleLabel.text = [self formattedDateForDate:date];
        [cell setSelected:[booksViewController.selectedDate isDateEqualToDate:date]];
    }
    else
    {
        [cell setSelected:[booksViewController.selectedGenre.genreName isEqualToString:itemToDisplay]];

        cell.titleLabel.text = (NSString*)itemToDisplay;
    }

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectionDatasource.itemsToDisplay.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentlySelectedItem == MainContainerSelectedItemDate)
    {
        NSDate *selectedDate = [self.selectionDatasource objectAtIndexPath:indexPath];
        self.dateLabel.text = [self formattedDateForDate:selectedDate];

        if ([self.currentViewController isKindOfClass:[BooksViewController class]])
        {
            BooksViewController *booksViewController = (BooksViewController*)self.currentViewController;

            if (![booksViewController.selectedDate isEqual:selectedDate]) {
                [booksViewController loadBooksForDate:selectedDate];
            }
        }
    }
    else if (self.currentlySelectedItem == MainContainerSelectedItemGenre)
    {
        NSString *newGenreString = [self.selectionDatasource objectAtIndexPath:indexPath];
        self.genreLabel.text = newGenreString;

        if ([self.currentViewController isKindOfClass:[BooksViewController class]])
        {
            BooksViewController *booksViewController = (BooksViewController*)self.currentViewController;

            if (![booksViewController.selectedGenre.genreName isEqualToString:newGenreString]) {
                [booksViewController loadBooksForGenreName:[self.selectionDatasource objectAtIndexPath:indexPath]];
            }
        }
    } else {
        NSLog(@"Error when selecting options");
    }

    [self hideSelectionViewWithAnimation:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 50.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSInteger numberOfItems = self.selectionDatasource.itemsToDisplay.count;

    CGFloat itemHeight = 50.0;
    CGFloat heightOfCollectionView = CGRectGetHeight(collectionView.frame);
    CGFloat topBottomInset = (heightOfCollectionView - (itemHeight * numberOfItems))/2;

    if (topBottomInset < 0) {
        topBottomInset = 40.0;
    }

    return UIEdgeInsetsMake(topBottomInset, 0.0, topBottomInset, 0.0);
}

- (MainContainerSelectionDatasource*)selectionDatasource
{
    if (!_selectionDatasource) {
        _selectionDatasource = [[MainContainerSelectionDatasource alloc] init];
    }

    return _selectionDatasource;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedView"]) {
        BooksViewController *booksViewController = (BooksViewController*)segue.destinationViewController;
        booksViewController.selectedDate = [NSDate date];
        self.currentMenuItem = MenuItemBooks;
        self.currentViewController = booksViewController;

        self.dateLabel.text = [self formattedDateForDate:[NSDate date]];

        self.buttonSelectionViewCenterConstraint.constant = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - dateformatting
- (NSDateFormatter*)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateStyle = NSDateFormatterLongStyle;
    }

    return _dateFormatter;
}

- (NSString*)formattedDateForDate:(NSDate*)date
{
    NSString *formattedDateString = @"";
    if ([date isDateToday]) {
        formattedDateString = @"Today";
    } else if ([date isDateYesterday]) {
        formattedDateString = @"Yesterday";
    } else {
        formattedDateString = [self.dateFormatter stringFromDate:date];
    }
    return formattedDateString;
}

#pragma mark - view methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([GeneralSettings showPushNotificationView]) {
        AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appdelegate startPushNotificationTimer];
    }

    self.view.backgroundColor = [UIColor backgroundColor];

    self.bottomContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomContainerView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    self.bottomContainerView.layer.shadowOpacity = 0.2;
    self.bottomContainerView.layer.shadowRadius = 1.5;

    self.genreLabel.text = [GeneralSettings favoriteCategory];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appdelegate checkToShowQuotesView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
