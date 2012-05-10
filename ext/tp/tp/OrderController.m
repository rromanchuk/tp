//
//  ViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderController.h"
#import "UIBarButtonItem+Borderless.h"

@interface OrderController ()

@end

@implementation OrderController

@synthesize navigationBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    UIImage *gearImage = [UIImage imageNamed:@"gear.png"];
    UIBarButtonItem *configButton = [UIBarButtonItem barItemWithImage:gearImage target:self action:@selector(config)];
    self.navigationBar.topItem.rightBarButtonItem = configButton;
    self.navigationBar.topItem.title = @"Tap on the type of roll you want.";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)config
{
    
}

@end
