//
//  LibraryTableViewCell.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 25/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *bookPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *bookAuthorLabel;
@property (nonatomic, weak) IBOutlet UIImageView *bookCoverImageView;
@property (nonatomic, weak) IBOutlet UIButton *librarySaveButton;
@property (nonatomic, weak) IBOutlet UIButton *buyButton;

@end
