//
//  StripeController.m
//  tp
//
//  Created by Ryan Romanchuk on 6/16/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import "StripeController.h"

@interface StripeController ()
@property (nonatomic) NSString *stripeKey;
@end

@implementation StripeController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stripeKey = [Config sharedConfig].stripeKey;
    NSURL *url = [NSURL URLWithString:[Config sharedConfig].baseURL];
    NSLog(@"%@", url);
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
	// Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Webview did finish loading");
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@""]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
