    //
//  WebViewController.m
//  WebView
//
//  Created by Ajay Chainani on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize urlString;

#pragma mark -
#pragma mark Application Lifecycle

- (void)loadView
{	
	urlString = @"http://huwai.xici.net";
    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.autoresizesSubviews = YES;
	self.view = contentView;
	
    //set the web frame size
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y = 0;
	
    //add the web view
	theWebView = [[UIWebView alloc] initWithFrame:webFrame];
	theWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	theWebView.scalesPageToFit = YES;
	theWebView.delegate = self;
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *req = [NSURLRequest requestWithURL:url];
	[theWebView loadRequest:req];
	
	[self.view addSubview: theWebView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    whirl = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	whirl.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    whirl.center = self.view.center;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: whirl];
    
//	[self.navigationController setToolbarHidden:NO animated:NO];
	
    [self updateToolbar];

}

-(void)updateToolbar {
    
	UIBarButtonItem *backButton =	[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon"] style:UIBarButtonItemStylePlain target:theWebView action:@selector(goBack)];
	UIBarButtonItem *forwardButton =	[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forwardIcon"] style:UIBarButtonItemStylePlain target:theWebView action:@selector(goForward)];
    
    [backButton setEnabled:theWebView.canGoBack];
    [forwardButton setEnabled:theWebView.canGoForward];
    
    UIBarButtonItem *refreshButton = nil;
    if (theWebView.loading) {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:theWebView action:@selector(stopLoading)];
    } else {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:theWebView action:@selector(reload)];
    }
    
//	UIBarButtonItem *openButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction)];
//    UIBarButtonItem *spacing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
//    NSArray *contents = [[NSArray alloc] initWithObjects:backButton, spacing, forwardButton, spacing, spacing, spacing, nil];
//    NSArray *contents = [[NSArray alloc] initWithObjects:backButton, spacing, forwardButton, spacing, spacing, refreshButton, nil];
    
//    [self setToolbarItems:contents animated:NO];
    self.navigationItem.leftBarButtonItems = @[backButton,forwardButton];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
    //[self.navigationController setToolbarHidden:YES animated:YES];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == (UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft));
}

#pragma mark UIWebView delegate methods

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	return YES;
}

- (void) webViewDidStartLoad: (UIWebView * ) webView {    
    [whirl startAnimating]; 
    [self updateToolbar];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@",webView.request.URL.absoluteString);
    [self updateToolbar];
//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"]; 
    [whirl stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateToolbar];
    [whirl stopAnimating];
    
    //handle error    
}

#pragma mark -
#pragma mark ActionSheet methods

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0 && theWebView.request.URL != nil) {
		[[UIApplication sharedApplication] openURL:theWebView.request.URL];
	}
}

- (void)shareAction {

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
										cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
										otherButtonTitles:@"Open in Safari", nil];
	
	[actionSheet showInView: self.view];
	
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    //deallocate web view
    if (theWebView.loading)
        [theWebView stopLoading];
    
    theWebView.delegate = nil;
    theWebView = nil;
}

- (void)dealloc
{
    
    //make sure that it has stopped loading before deallocating
    if (theWebView.loading)
        [theWebView stopLoading];
    
    //deallocate web view
	theWebView.delegate = nil;
	theWebView = nil;
    
}

//- (oneway void)release
//{
//    if (![NSThread isMainThread]) {
//        [self performSelectorOnMainThread:@selector(release) withObject:nil waitUntilDone:NO];
//    } else {
//        [super release];
//    }
//}

@end
