//
//  BooksViewController.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 29/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "ImageDownloadBaseViewController.h"

@class BookCollectionObject;

@interface BooksViewController : ImageDownloadBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UILabel *recommendedByLabel;
@property (nonatomic, weak) IBOutlet UILabel *collectionTitleLabel;

@property (nonatomic, copy) NSString *selectedGenre;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) BookCollectionObject *selectedCollectionObject;

- (void)loadBooksForDate:(NSDate*)date;
- (void)loadBooksForGenre:(NSString*)genreString;

- (IBAction)backButtonPressed:(id)sender;

@end
