//
//  MPAdBrowserController.h
//  MoPub
//
//  Created by Nafis Jamal on 1/19/11.
//  Copyright 2011 MoPub, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef CF_RETURNS_RETAINED
#if __has_feature(attribute_cf_returns_retained)
#define CF_RETURNS_RETAINED __attribute__((cf_returns_retained))
#else
#define CF_RETURNS_RETAINED
#endif
#endif

@protocol MPAdBrowserControllerDelegate;

@interface MPAdBrowserController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
{
	id<MPAdBrowserControllerDelegate> __unsafe_unretained _delegate;
	UIWebView *_webView;
	UIBarButtonItem *_backButton;
	UIBarButtonItem *_forwardButton;
	UIBarButtonItem *_refreshButton;
	UIBarButtonItem *_safariButton;
	UIBarButtonItem *_doneButton;
	UIActivityIndicatorView *_spinner;
	UIBarButtonItem *_spinnerItem;
	UIActionSheet *_actionSheet;
	BOOL _actionSheetIsShowing;
	NSURL *_URL;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *safariButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *spinnerItem;

@property (nonatomic, unsafe_unretained) id<MPAdBrowserControllerDelegate> delegate;
@property (nonatomic, copy) NSURL *URL;


- (id)initWithURL:(NSURL *)URL delegate:(id<MPAdBrowserControllerDelegate>)delegate;

// Navigation methods.
- (IBAction)back;
- (IBAction)forward;
- (IBAction)refresh;
- (IBAction)safari;
- (IBAction)done;

// Drawing methods.
- (CGContextRef)createContext CF_RETURNS_RETAINED;
- (UIImage *)backArrowImage;
- (UIImage *)forwardArrowImage;


@end

@protocol MPAdBrowserControllerDelegate <NSObject>
@required
- (void)dismissBrowserController:(MPAdBrowserController *)browserController;
- (void)dismissBrowserController:(MPAdBrowserController *)browserController animated:(BOOL)animated;
@end