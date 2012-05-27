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
@synthesize regularButton; 
@synthesize premiumButton;
@synthesize orderButton; 
@synthesize qtyButton;
@synthesize qtyButtonSmall;
@synthesize qtyTable; 

//Form
@synthesize nameLabel; 
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize stateLabel;
@synthesize zipLabel;
@synthesize helperText;

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
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Regular" size:18.0], UITextAttributeFont, nil];
	// Do any additional setup after loading the view, typically from a nib.
    self.qtyTable.hidden = true;
    self.qtyTable.backgroundColor = [UIColor blackColor];
    
    self.qtyButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:35.0];
    self.qtyButtonSmall.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:30.0];
    //Checkout form
    self.nameLabel.font = [UIFont fontWithName:@"ProximaNova-Semiboldr" size:30.0];
    self.addressLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:30.0];
    self.stateLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:30.0];
    self.cityLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:30.0];
    self.zipLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:30.0];
    self.helperText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"inside num rows in section");
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // configure your cell here...
    cell.textLabel.text = @"One Roll";
    cell.textLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)config
{
    
}

- (IBAction)qtyChange:(id)sender {
    if (qtyTable.hidden) {
        qtyTable.hidden = false;
    } else {
        qtyTable.hidden = true;
    }
}

@end
