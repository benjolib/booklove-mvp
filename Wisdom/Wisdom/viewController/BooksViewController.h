//
//  BooksViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ImageDownloadBaseViewController.h"
#import "BookGenre.h"
#import "LoadingCollectionView.h"

@class BookObject, BookCollectionObject;

@interface BooksViewController : ImageDownloadBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet LoadingCollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UILabel *recommendedByLabel;
@property (nonatomic, weak) IBOutlet UILabel *collectionTitleLabel;

@property (nonatomic, strong) BookCollectionObject *selectedCollectionObject;
@property (nonatomic, strong) BookObject *bookToDiplay;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewTopBorderLayoutConstraint;

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) BookGenre *selectedGenre;

- (void)loadBooksForDate:(NSDate*)date;
- (void)loadBooksForGenre:(BookGenre*)genre;

- (IBAction)backButtonPressed:(id)sender;

- (IBAction)bookFlipButtonPressed:(UIButton*)button;
- (IBAction)bookmarkButtonPressed:(UIButton*)button;

@end
