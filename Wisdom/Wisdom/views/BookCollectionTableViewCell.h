//
//  BookCollectionTableViewCell.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCollectionTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *collectionNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *coverImageView;

@end
