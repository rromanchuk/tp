//
//  ViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderController.h"
#import "UIBarButtonItem+Borderless.h"
#import "User.h"
@interface OrderController ()

@end

@implementation OrderController

@synthesize navigationBar;
@synthesize rightBarButton;
@synthesize regularButton; 
@synthesize premiumButton;
@synthesize orderButton; 
@synthesize qtyButton;
@synthesize qtyButtonSmall;
@synthesize qtyTable; 

@synthesize scrollView;

//Form
@synthesize nameLabel;
@synthesize nameTextField;
@synthesize addressLabel;
@synthesize addressTextField; 
@synthesize cityLabel;
@synthesize cityTextField;
@synthesize stateLabel;
@synthesize stateTextField;
@synthesize zipLabel;
@synthesize zipTextField;
@synthesize helperText;

//checkout
@synthesize cancelOrder; 
@synthesize thatsItLabel; 
@synthesize deliveryEst;
@synthesize isOnCheckout;

@synthesize activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    UIImage *gearImage = [UIImage imageNamed:@"gear.png"];
    UIBarButtonItem *configButton = [UIBarButtonItem barItemWithImage:gearImage target:self action:@selector(config)];
    //self.navigationBar.topItem.rightBarButtonItem = configButton;
    self.rightBarButton = configButton;
    self.navigationBar.topItem.title = @"Tap on the type of roll you want.";
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Regular" size:18.0], UITextAttributeFont, nil];
	// Do any additional setup after loading the view, typically from a nib.
    
    //scroll view
    self.scrollView.contentSize = CGSizeMake(320,1000);
    self.scrollView.scrollEnabled = NO;
    
    self.qtyTable.hidden = true;
    self.qtyTable.backgroundColor = [UIColor blackColor];
    
    self.qtyButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:35.0];
    [self.qtyButton setTitle:@"4 Rolls" forState:UIControlStateNormal];
    self.qtyButtonSmall.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:30.0];
    [self.qtyButtonSmall setTitle:@"4 Rolls" forState:UIControlStateNormal];
    
    
    //Checkout form
    self.nameLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.addressLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.stateLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.cityLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.zipLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.helperText.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15.0];
    
    //Checkout 
    self.thatsItLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
    self.deliveryEst.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    self.isOnCheckout = NO;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"4 Rolls";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"8 Rolls";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"12 Rolls";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"16 Rolls";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"index path %d", indexPath.row);
    NSLog(@"did select row");
    if (indexPath.row == 0) {
        [qtyButton setTitle:@"4 Rolls" forState:UIControlStateNormal];
        [qtyButtonSmall setTitle:@"4 Rolls" forState:UIControlStateNormal];
    } else if (indexPath.row == 1) {
        [qtyButton setTitle:@"8 Rolls" forState:UIControlStateNormal];
        [qtyButtonSmall setTitle:@"8 Rolls" forState:UIControlStateNormal];
    } else if (indexPath.row == 2) {
        [qtyButton setTitle:@"12 Rolls" forState:UIControlStateNormal];
        [qtyButtonSmall setTitle:@"12 Rolls" forState:UIControlStateNormal];
    } else if (indexPath.row == 3) {
        [qtyButton setTitle:@"16 Rolls" forState:UIControlStateNormal];
        [qtyButtonSmall setTitle:@"16 Rolls" forState:UIControlStateNormal];
    }
    self.qtyTable.hidden = YES;
    self.qtyButton.selected = NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"inside diddeselect");
    self.qtyTable.hidden = YES;
    self.qtyButton.selected = NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self numberOfSectionsInTableView:tableView] == (section+1)){
        return [UIView new];
    }       
    return nil;
}

- (void)config
{
    
}

//Scroll view

-(void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    if (isOnCheckout && (sender.contentOffset.y < 474.0)) {
        [self scrollToTop:sender];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)sender willDecelerate:(BOOL)decelerate {
    if( decelerate == NO) {
        if (isOnCheckout && (sender.contentOffset.y < 474.0)) {
            [self scrollToTop:sender];
        }     
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (isOnCheckout) {
        [self.nameTextField becomeFirstResponder];
    }
}


// keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

-(IBAction)removeKeyboard {
    [self.activeField resignFirstResponder];
}

- (IBAction)scrollToCheckout:(id)sender {
    self.isOnCheckout = YES;
    [self.scrollView setContentOffset:CGPointMake(0.0, 474.0) animated:YES]; 
    self.scrollView.scrollEnabled = YES;
}

- (IBAction)scrollToTop:(id)sender {
    [self removeKeyboard];
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    self.scrollView.scrollEnabled = NO;
    self.isOnCheckout = NO;
}

- (IBAction)qtyChange:(id)sender {
    NSLog(@"in quantity change");
    if (self.qtyTable.hidden) {
        self.qtyTable.hidden = NO;
        self.qtyButton.selected = YES; 
    } else {
        self.qtyTable.hidden = YES;
        self.qtyButton.selected = NO;
    }
}

- (IBAction)sendOrder:(id)sender {
    User *user = [User currentUser];
    user.name = self.nameTextField.text; 
    user.address = self.addressTextField.text; 
    user.state = self.stateTextField.text;
    user.zip = self.zipTextField.text;
    [user save];
}

@end
