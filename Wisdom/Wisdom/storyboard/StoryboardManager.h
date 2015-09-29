//
//  StoryboardManager.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MainContainerViewController, BookCollectionViewController, BooksViewController, QuotesViewController, LibraryViewController, OnboardingViewController, PushNotificationViewController;

@interface StoryboardManager : NSObject

+ (PushNotificationViewController*)pushNotificationViewController;
+ (MainContainerViewController*)mainContainerViewController;

+ (OnboardingViewController*)onboardingViewController;
+ (QuotesViewController*)quotesViewController;

+ (UINavigationController*)collectionNavigationController;
+ (BookCollectionViewController*)bookCollectionViewController;
+ (LibraryViewController*)libraryViewController;
+ (BooksViewController*)booksViewController;

@end
