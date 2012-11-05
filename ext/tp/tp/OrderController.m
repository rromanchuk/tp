//
//  ViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderController.h"
#import "UIBarButtonItem+Borderless.h"
#import "User+Manage.h"
#import "Stripe.h"
#import "Config.h"
#import "RestUser.h"
@interface OrderController ()

@end

@implementation OrderController


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
    
    //scroll view
    self.scrollView.contentSize = CGSizeMake(320,1000);
    self.scrollView.scrollEnabled = NO;
    
    self.qtyTable.hidden = true;
    self.qtyTable.backgroundColor = [UIColor blackColor];
    
    self.qtyButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:35.0];
    [self.qtyButton setTitle:@"6 Rolls" forState:UIControlStateNormal];
    self.qtyButtonSmall.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:30.0];
    [self.qtyButtonSmall setTitle:@"6 Rolls" forState:UIControlStateNormal];
   
    self.premiumButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    self.regularButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];

    
    self.orderButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    [self.orderButton setTitle:@"$4" forState:UIControlStateNormal];
    
    //Checkout form
    self.nameLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.address1Label.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.stateLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.cityLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.zipLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.helperText.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15.0];
    
    //Checkout 
    self.thatsItLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
    self.deliveryEst.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    self.isOnCheckout = NO;
    //self.currentUser = [User currentUser:self.managedObjectContext];

    [self loadForm];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadForm];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowReceipt"]){
        NSLog(@"In prepare for segue");
        ShowReceiptViewController *vc = (ShowReceiptViewController *)segue.destinationViewController;
        vc.delegate = self;
    }
}

- (void)loadForm {
    DLog(@"name %@ and address %@ customerid %@ state %@  zip %@", self.currentUser.name, self.currentUser.address1, self.currentUser.stripeCustomerId, self.currentUser.state, self.currentUser.zip);
    self.nameTextField.text = self.currentUser.name;
    self.address1TextField.text = self.currentUser.address1;
    self.cityTextField.text = self.currentUser.city;
    self.stateTextField.text = self.currentUser.state;
    self.zipTextField.text = self.currentUser.zip;
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
        cell.textLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"6 Rolls";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"12 Rolls";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"24 Rolls";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"index path %d", indexPath.row);
    NSLog(@"did select row");
    if (indexPath.row == 0) {
        [self.qtyButton setTitle:@"6 Rolls" forState:UIControlStateNormal];
        [self.qtyButtonSmall setTitle:@"6 Rolls" forState:UIControlStateNormal];
        [self.regularButton setTitle:@"$6" forState:UIControlStateNormal];
        [self.premiumButton setTitle:@"$9" forState:UIControlStateNormal];
        if (self.premiumButton.selected) {
            [self.orderCheckoutButton setTitle:@"$9" forState:UIControlStateNormal];
        } else {
            [self.orderCheckoutButton setTitle:@"$6" forState:UIControlStateNormal];
        }
    } else if (indexPath.row == 1) {
        [self.qtyButton setTitle:@"12 Rolls" forState:UIControlStateNormal];
        [self.qtyButtonSmall setTitle:@"12 Rolls" forState:UIControlStateNormal];
        [self.regularButton setTitle:@"$10" forState:UIControlStateNormal];
        [self.premiumButton setTitle:@"$15" forState:UIControlStateNormal];
        if (self.premiumButton.selected) {
            [self.orderCheckoutButton setTitle:@"$15" forState:UIControlStateNormal];
        } else {
            [self.orderCheckoutButton setTitle:@"$10" forState:UIControlStateNormal];
        }
    } else if (indexPath.row == 2) {
        [self.qtyButton setTitle:@"24 Rolls" forState:UIControlStateNormal];
        [self.qtyButtonSmall setTitle:@"24 Rolls" forState:UIControlStateNormal];
        [self.regularButton setTitle:@"$18" forState:UIControlStateNormal];
        [self.premiumButton setTitle:@"$27" forState:UIControlStateNormal];
        if (self.premiumButton.selected) {
            [self.orderCheckoutButton setTitle:@"$27" forState:UIControlStateNormal];
        } else {
            [self.orderCheckoutButton setTitle:@"$18" forState:UIControlStateNormal];
        }
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
    if (self.isOnCheckout && (sender.contentOffset.y < 474.0)) {
        [self scrollToTop:sender];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)sender willDecelerate:(BOOL)decelerate {
    if( decelerate == NO) {
        if (self.isOnCheckout && (sender.contentOffset.y < 474.0)) {
            [self scrollToTop:sender];
        }     
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.isOnCheckout) {
        [self.nameTextField becomeFirstResponder];
    }
}

// keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
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
//        
    self.currentUser.name = self.nameTextField.text;
//    //user.email = self.emailTextField.text;
    self.currentUser.address1 = self.address1TextField.text;
    self.currentUser.state = self.stateTextField.text;
    self.currentUser.zip = self.zipTextField.text;
    self.currentUser.city = self.cityTextField.text;
    self.currentUser.country = @"United States";
    [self saveContext];
    DLog(@"name %@ and address %@ customerid %@ state %@  zip %@", self.currentUser.name, self.currentUser.address1, self.currentUser.stripeCustomerId, self.currentUser.state, self.currentUser.zip);
    if (self.currentUser.stripeCustomerId) {
        //[self.currentUser chargeCustomer:[NSNumber numberWithInteger:400]];
    } else {
        [self.currentUser createStripeCustomer];
    }
    
    [SVProgressHUD showErrorWithStatus:@"Sending order..."];
    [RestUser order:self.currentUser onLoad:^(id object) {
        DLog(@"success");
        [SVProgressHUD dismiss];
        [((OrderController *)self.scrollView.delegate) performSegueWithIdentifier:@"ShowReceipt" sender:self];
    } onError:^(NSString *error) {
        DLog(@"failure");
        [SVProgressHUD showErrorWithStatus:error];
    }];
    
}

- (void)didDismissReceipt {
    [self dismissModalViewControllerAnimated:YES];
    [self scrollToTop:self];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *_managedObjectContext = self.managedObjectContext;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            //DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}


@end
