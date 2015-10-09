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
+ (DonateViewController*)donateViewController
{
    return (DonateViewController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"donateViewController"];
}

+ (PushNotificationViewController*)pushNotificationViewController
{
    return (PushNotificationViewController*)[[self notificationStoryboard] instantiateInitialViewController];
}

+ (InviteFriendViewController*)inviteFriendViewController
{
    return (InviteFriendViewController*)[[self notificationStoryboard] instantiateViewControllerWithIdentifier:@"inviteFriendViewController"];
}

+ (EmailViewController*)emailViewController
{
    return (EmailViewController*)[[self notificationStoryboard] instantiateViewControllerWithIdentifier:@"EmailViewController"];
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

+ (CollectionsNavigationController*)collectionNavigationController
{
    return (CollectionsNavigationController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"collectionNavigationController"];
}

+ (LibraryNavigationController*)libraryNavigationController
{
    return (LibraryNavigationController*)[[self mainStoryboard] instantiateViewControllerWithIdentifier:@"libraryNavigationController"];
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
