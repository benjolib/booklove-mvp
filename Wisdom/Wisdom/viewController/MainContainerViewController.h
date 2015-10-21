//
//  MainContainerViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabButton;

typedef NS_ENUM(NSUInteger, MenuItem) {
    MenuItemNone,
    MenuItemCollection,
    MenuItemBooks,
    MenuItemLibrary,
};

@interface MainContainerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *selectionCollectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *selectionViewHeightConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topbarYOriginConstraint;

@property (nonatomic, weak) IBOutlet UIView *topbarView;
@property (nonatomic, weak) IBOutlet UIView *bottomContainerView;
@property (nonatomic, weak) IBOutlet TabButton *collectionButton;
@property (nonatomic, weak) IBOutlet TabButton *booksButton;
@property (nonatomic, weak) IBOutlet TabButton *libraryButton;
@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, weak) IBOutlet UIButton *genreButton;
@property (nonatomic, weak) IBOutlet UIButton *dateButton;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *genreLabel;

@property (nonatomic, weak) IBOutlet UIView *buttonSelectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonSelectionViewCenterConstraint;

- (IBAction)genreButtonPressed:(id)sender;
- (IBAction)dateButtonPressed:(id)sender;

- (IBAction)collectionButtonPressed:(id)sender;
- (IBAction)booksButtonPressed:(id)sender;
- (IBAction)libraryButtonPressed:(id)sender;

- (void)changeToMenuItem:(MenuItem)menuItem;

- (void)setTopBarVisible:(BOOL)visible;

@end
