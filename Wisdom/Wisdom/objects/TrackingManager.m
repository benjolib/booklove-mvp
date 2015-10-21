//
//  TrackingManager.m
//  Wisdom
//
//  Created by Sztanyi Szabolcs on 15/10/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

#import "TrackingManager.h"
#import "Adjust.h"

@implementation TrackingManager

+ (instancetype)sharedManager
{
    static TrackingManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupAdjustTracker];
    }
    return self;
}

#pragma mark - adjustTracking
- (void)setupAdjustTracker
{
    NSString *yourAppToken = @"t25rkmdyveul";
    NSString *environment;
#ifdef DEBUG
    environment = ADJEnvironmentSandbox;
#else
    environment = ADJEnvironmentProduction;
#endif
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:yourAppToken
                                                environment:environment];
    [Adjust appDidLaunch:adjustConfig];
    [adjustConfig setLogLevel:ADJLogLevelDebug];
}

- (void)trackEventWithToken:(NSString*)token
{
    ADJEvent *event = [ADJEvent eventWithEventToken:token];
    [Adjust trackEvent:event];
}

- (void)trackUserLaunchedTheApp
{
    [self trackEventWithToken:@"bj553s"];
}

- (void)trackPushNotificationOK
{
    [self trackEventWithToken:@"dagy9b"];
}

- (void)trackPushNotificationNotNow
{
    [self trackEventWithToken:@"9thf7s"];
}

// Main
- (void)trackSelectedBooksTab
{
    [self trackEventWithToken:@"79dept"];
}

- (void)trackSelectedLibraryTab
{
    [self trackEventWithToken:@"txksxj"];
}

- (void)trackSelectedCollectionTab
{
    [self trackEventWithToken:@"z8a13q"];
}

- (void)trackSelectedDonationTab
{
    [self trackEventWithToken:@"6xeizp"];
}

// Recommendation
- (void)trackRecommendationBookCover
{
    [self trackEventWithToken:@"uytwct"];
}

- (void)trackRecommendationSwipeToBrowse
{
    [self trackEventWithToken:@"ojqxpq"];
}

- (void)trackRecommendationDate
{
    [self trackEventWithToken:@"tgrqj3"];
}

- (void)trackRecommendationGenre
{
    [self trackEventWithToken:@"18s0mg"];
}

// Book details
- (void)trackBookDetailFlipped
{
    [self trackEventWithToken:@"3gs6cp"];
}

- (void)trackBookDetailSwiped
{
    [self trackEventWithToken:@"63oy3o"];
}

- (void)trackBookDetailBookmarked
{
    [self trackEventWithToken:@"2ib03k"];
}

- (void)trackBookDetailBuy
{
    [self trackEventWithToken:@"rxntbn"];
}

// Library
- (void)trackLibraryBookmarkRemove
{
    [self trackEventWithToken:@"83mwhb"];
}

- (void)trackLibraryBuyButton
{
    [self trackEventWithToken:@"ev5qvt"];
}

- (void)trackLibraryBookFlipped
{
    [self trackEventWithToken:@"te6psa"];
}

// Email overlay
- (void)trackEmailOverlayClosed
{
    [self trackEventWithToken:@"f3ff4v"];
}

- (void)trackEmailOverlaySubmitted
{
    [self trackEventWithToken:@"75lq9h"];
}

// Invite overlay
- (void)trackInviteTapClosed
{
    [self trackEventWithToken:@"l07ymc"];
}

- (void)trackInviteTapsInvite
{
    [self trackEventWithToken:@"517zpt"];
}

- (void)trackInviteTapsOne
{
    [self trackEventWithToken:@"58k90f"];
}

- (void)trackInviteTapsTwo
{
    [self trackEventWithToken:@"l7yarc"];
}

- (void)trackInviteTapsThree
{
    [self trackEventWithToken:@"vanb27"];
}

- (void)trackInviteTapsFour
{
    [self trackEventWithToken:@"nbewzg"];
}

- (void)trackInviteTapsFive
{
    [self trackEventWithToken:@"4terdb"];
}

// Collection
- (void)trackCollectionSelected
{
    [self trackEventWithToken:@"c5idcn"];
}

- (void)trackCollectionClosed
{
    [self trackEventWithToken:@"1i71af"];
}

- (void)trackCollectionBookSelected
{
    [self trackEventWithToken:@"yvqem3"];
}

- (void)trackCollectionSwipe
{
    [self trackEventWithToken:@"55tplt"];
}

// Donation
- (void)trackDonateButtonPressed
{
    [self trackEventWithToken:@"69with"];
}

- (void)trackDonateViewClosed
{
    [self trackEventWithToken:@"xnnfqd"];
}

@end
