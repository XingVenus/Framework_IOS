//
//  PayView.m
//  HuWai
//
//  Created by WmVenusMac on 15-4-3.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "PayView.h"
#import "OrderDone.h"

static NSString *successUrl = @"%@/order/success?oid=%@&isMobile=1";
static NSString *failUrl = @"%@/order/fail?oid=%@&isMobile=1";

@interface PayView ()

@end

@implementation PayView

@synthesize urlString;

#pragma mark -
#pragma mark Application Lifecycle

- (void)loadView
{
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
//    self.navigationItem.titleView = whirl;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    [self updateToolbar];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [MobClick endLogPageView:self.title];
}

-(void)updateToolbar {
    
    UIBarButtonItem *backButton =	[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon.png"] style:UIBarButtonItemStylePlain target:theWebView action:@selector(goBack)];
    UIBarButtonItem *forwardButton =	[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forwardIcon.png"] style:UIBarButtonItemStylePlain target:theWebView action:@selector(goForward)];
    
    [backButton setEnabled:theWebView.canGoBack];
    [forwardButton setEnabled:theWebView.canGoForward];
    
    UIBarButtonItem *refreshButton = nil;
    if (theWebView.loading) {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:theWebView action:@selector(stopLoading)];
    } else {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:theWebView action:@selector(reload)];
    }
    
    UIBarButtonItem *openButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction)];
    UIBarButtonItem *spacing       = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *contents = [[NSArray alloc] initWithObjects:backButton, spacing, forwardButton, spacing, spacing, spacing, openButton, nil];
    //NSArray *contents = [[NSArray alloc] initWithObjects:backButton, spacing, forwardButton, spacing, refreshButton, spacing, openButton, nil];
    
    [self setToolbarItems:contents animated:NO];
    
    
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == (UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft));
}

#pragma mark UIWebView delegate methods

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    //
    DLog(@"%@",request.URL.absoluteString);
    NSString *formatSuccess = [NSString stringWithFormat:successUrl,APP_MINI_PUBLISH_HTTP_URL,self.orderId];
    NSString *formatFail = [NSString stringWithFormat:failUrl,APP_MINI_PUBLISH_HTTP_URL,self.orderId];
    if ([request.URL.absoluteString isEqualToString:formatSuccess]) {
        //跳转到成功页面
        [self performSegueWithIdentifier:@"orderdone" sender:self];
        if ([[APPInfo shareInit].payFromType isEqualToString:@"orderlist"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyOrderListLoadNotification object:nil];
        }
        return NO;
    }else if([request.URL.absoluteString isEqualToString:formatFail]){
        [self showMessageWithThreeSecondAtCenter:@"支付失败" afterDelay:1];
        return NO;
    }
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"orderdone"]){
        OrderDone *orderDoneView = segue.destinationViewController;
        orderDoneView.orderDetailModel = self.orderDetailModel;
    }
}
@end
