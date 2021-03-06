//
//  MPMRAIDBannerCustomEvent.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import "MPMRAIDBannerCustomEvent.h"
#import "MPLogging.h"
#import "MPAdConfiguration.h"
#import "MPInstanceProvider.h"

@interface MPMRAIDBannerCustomEvent ()

@property (nonatomic, retain) MRAdView *banner;

@end

@implementation MPMRAIDBannerCustomEvent

@synthesize banner = _banner;

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    return NO;
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Loading MoPub MRAID banner");
    MPAdConfiguration *configuration = [self.delegate configuration];

    CGRect adViewFrame = CGRectZero;
    if ([configuration hasPreferredSize]) {
        adViewFrame = CGRectMake(0, 0, configuration.preferredSize.width,
                                 configuration.preferredSize.height);
    }

    self.banner = [[[MRAdView alloc] initWithFrame:adViewFrame
                                   allowsExpansion:YES
                                  closeButtonStyle:MRAdViewCloseButtonStyleAdControlled
                                     placementType:MRAdViewPlacementTypeInline] autorelease];
    self.banner.delegate = self;
    [self.banner loadCreativeWithHTMLString:[configuration adResponseHTMLString]
                                    baseURL:nil];
}

- (void)dealloc
{
    self.banner.delegate = nil;
    self.banner = nil;

    [super dealloc];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)newOrientation
{
    [self.banner rotateToOrientation:newOrientation];
}

#pragma mark - MPAdWebViewAgentDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return [self.delegate viewControllerForPresentingModalView];
}

- (void)adDidLoad:(MRAdView *)adView
{
    MPLogInfo(@"MoPub MRAID banner did load");
    [self.delegate bannerCustomEvent:self didLoadAd:adView];
}

- (void)adDidFailToLoad:(MRAdView *)adView
{
    MPLogInfo(@"MoPub MRAID banner did fail");
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)closeButtonPressed
{
    //don't care
}

- (void)appShouldSuspendForAd:(MRAdView *)adView
{
    MPLogInfo(@"MoPub MRAID banner will begin action");
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)appShouldResumeFromAd:(MRAdView *)adView
{
    MPLogInfo(@"MoPub MRAID banner did end action");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

@end
