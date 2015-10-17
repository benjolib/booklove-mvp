//
//  TrackingManager.h
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 15/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackingManager : NSObject

+ (instancetype)sharedManager;

- (void)trackLibraryBookmarkRemove;
- (void)trackLibraryBuyButton;
- (void)trackLibraryBookFlipped;

- (void)trackPushNotificationOK;
- (void)trackPushNotificationNotNow;

- (void)trackSelectedBooksTab;
- (void)trackSelectedLibraryTab;
- (void)trackSelectedCollectionTab;
- (void)trackSelectedDonationTab;

- (void)trackBookDetailFlipped;
- (void)trackBookDetailSwiped;
- (void)trackBookDetailBookmarked;
- (void)trackBookDetailBuy;

- (void)trackRecommendationBookCover;
- (void)trackRecommendationSwipeToBrowse;
- (void)trackRecommendationDate;
- (void)trackRecommendationGenre;

- (void)trackInviteTapClosed;
- (void)trackInviteTapsInvite;
- (void)trackInviteTapsOne;
- (void)trackInviteTapsTwo;
- (void)trackInviteTapsThree;
- (void)trackInviteTapsFour;
- (void)trackInviteTapsFive;

- (void)trackEmailOverlayClosed;
- (void)trackEmailOverlaySubmitted;

- (void)trackCollectionSelected;
- (void)trackCollectionClosed;
- (void)trackCollectionBookSelected;
- (void)trackCollectionSwipe;

- (void)trackDonateButtonPressed;
- (void)trackDonateViewClosed;

@end
