//
//  StoryboardManager.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 21/09/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "StoryboardManager.h"

@implementation StoryboardManager

#pragma mark - storyboards
+ (UIStoryboard*)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyboard;
}

+ (UIStoryboard*)notificationStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Notification" bundle:nil];
    return storyboard;
}

+ (UIStoryboard*)onboardingStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
    return storyboard;
}

#pragma mark - viewcontrollers
+ (PushNotificationViewController*)pushNotificationViewController
{
    return (PushNotificationViewController*)[[self notificationStoryboard] instantiateInitialViewController];
}

+ (MainContainerViewController*)mainContainerViewController
{
    return (MainContainerViewController*)[[self mainStoryboard] instantiateInitialViewController];
}

+ (OnboardingViewController*)onboardingViewController
{
    return (OnboardingViewController*)[[self onboardingStoryboard] instantiateInitialViewController];
}

+ (QuotesViewController*)quotesViewController
{
    return (QuotesViewController*)[[self onboardingStoryboard] instantiateViewControllerWithIdentifier:@"QuotesViewController"];
}

+ (UINavigationController*)collectionNavigationController
{
    return (UINavigationController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"collectionNavigationController"];
}

+ (BookCollectionViewController*)bookCollectionViewController
{
    return (BookCollectionViewController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"BookCollectionViewController"];
}

+ (BooksViewController*)booksViewController
{
    return (BooksViewController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"BooksViewController"];
}

+ (LibraryViewController*)libraryViewController
{
    return (LibraryViewController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"LibraryViewController"];
}

@end
