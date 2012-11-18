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
#import "SVProgressHUD.h"
@interface OrderController () {
    RollQualityType selectedQuality;
    RollQuantityType selectedQuantity;
    NSInteger amountInCents;
}

@end

@implementation OrderController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder])
    {
        selectedQuantity = RollQuantityType6;
        selectedQuality = RollQualityTypeRegular;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    UIImage *gearImage = [UIImage imageNamed:@"gear.png"];
    UIBarButtonItem *configButton = [UIBarButtonItem barItemWithImage:gearImage target:self action:@selector(scrollToCheckout:)];
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
    self.orderCheckoutButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    [self.orderButton setTitle:@"$4" forState:UIControlStateNormal];
    
    //Checkout form
    self.nameLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.address1Label.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.stateLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.cityLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.zipLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.creditCardLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.csvLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.expirationLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];

    self.helperText.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15.0];
    
    //Checkout 
    self.thatsItLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
    self.deliveryEst.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    self.isOnCheckout = NO;
    [self setupView];
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
        vc.order = (Order *)sender;
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
    [self setCreditCardLabel:nil];
    [self setCreditCardTextField:nil];
    [self setCsvLabel:nil];
    [self setCsvTextField:nil];
    [self setExpirationLabel:nil];
    [self setExpiryMonth:nil];
    [self setExpiryYear:nil];
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

- (void)setupView {
    DLog(@"selected quantity %d", selectedQuantity);
    switch (selectedQuantity) {
        case RollQuantityType6:
            [self.qtyButton setTitle:@"6 Rolls" forState:UIControlStateNormal];
            [self.qtyButtonSmall setTitle:@"6 Rolls" forState:UIControlStateNormal];
            [self.regularButton setTitle:@"$6" forState:UIControlStateNormal];
            [self.premiumButton setTitle:@"$9" forState:UIControlStateNormal];
            if (selectedQuality == RollQualityTypePremium) {
                [self.orderCheckoutButton setTitle:@"$9" forState:UIControlStateNormal];
                [self.orderButton setTitle:@"$9" forState:UIControlStateNormal];
                amountInCents = 900;
            } else {
                [self.orderCheckoutButton setTitle:@"$6" forState:UIControlStateNormal];
                [self.orderButton setTitle:@"$6" forState:UIControlStateNormal];
                amountInCents = 600;
            }
            break;
        case RollQuantityType12:
            [self.qtyButton setTitle:@"12 Rolls" forState:UIControlStateNormal];
            [self.qtyButtonSmall setTitle:@"12 Rolls" forState:UIControlStateNormal];
            [self.regularButton setTitle:@"$10" forState:UIControlStateNormal];
            [self.premiumButton setTitle:@"$15" forState:UIControlStateNormal];
            if (selectedQuality == RollQualityTypePremium) {
                [self.orderCheckoutButton setTitle:@"$15" forState:UIControlStateNormal];
                [self.orderButton setTitle:@"$15" forState:UIControlStateNormal];
                amountInCents = 1500;
            } else {
                [self.orderCheckoutButton setTitle:@"$10" forState:UIControlStateNormal];
                [self.orderButton setTitle:@"$10" forState:UIControlStateNormal];
                amountInCents = 1000;
            }

            break;
            
        case RollQuantityType24:
            [self.qtyButton setTitle:@"24 Rolls" forState:UIControlStateNormal];
            [self.qtyButtonSmall setTitle:@"24 Rolls" forState:UIControlStateNormal];
            [self.regularButton setTitle:@"$18" forState:UIControlStateNormal];
            [self.premiumButton setTitle:@"$27" forState:UIControlStateNormal];
            if (selectedQuality == RollQualityTypePremium) {
                [self.orderCheckoutButton setTitle:@"$27" forState:UIControlStateNormal];
                [self.orderButton setTitle:@"$27" forState:UIControlStateNormal];
                amountInCents = 2700;
            } else {
                [self.orderCheckoutButton setTitle:@"$18" forState:UIControlStateNormal];
                [self.orderButton setTitle:@"$18" forState:UIControlStateNormal];
                amountInCents = 1800;
            }

            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"index path %d", indexPath.row);
    NSLog(@"did select row");
    switch (indexPath.row) {
        case 0:
            selectedQuantity = RollQuantityType6;
            break;
        case 1:
            selectedQuantity = RollQuantityType12;
            break;
        case 2:
            selectedQuantity = RollQuantityType24;
            break;
        default:
            break;
    }
    [self setupView];
    self.qtyTable.hidden = YES;
    self.qtyButton.selected = NO;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self numberOfSectionsInTableView:tableView] == (section+1)){
        return [UIView new];
    }       
    return nil;
}

- (IBAction)didTapRegular:(id)sender {
    ALog(@"did tap regular");
    self.regularButton.selected = YES;
    self.premiumButton.selected = NO;
    selectedQuality = RollQualityTypeRegular;
    [self setupView];
}

- (IBAction)didTapPremium:(id)sender {
    ALog(@"did tap premium");
    self.regularButton.selected = NO;
    self.premiumButton.selected = YES;
    selectedQuality = RollQualityTypePremium;
    [self setupView];
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

- (IBAction)didTapCheckout:(id)sender {
    if ([self.currentUser hasCustomerId] && [self.currentUser addressIsValid]) {
        [self sendOrder:self];
    } else {
        [self scrollToCheckout:sender];
    }
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
    [SVProgressHUD showWithStatus:@"Sending your order..."];
    self.currentUser.name = self.nameTextField.text;
    self.currentUser.address1 = self.address1TextField.text;
    self.currentUser.state = self.stateTextField.text;
    self.currentUser.zip = self.zipTextField.text;
    self.currentUser.city = self.cityTextField.text;
    self.currentUser.country = @"United States";
    [self saveContext];
    DLog(@"name %@ and address %@ customerid %@ state %@  zip %@", self.currentUser.name, self.currentUser.address1, self.currentUser.stripeCustomerId, self.currentUser.state, self.currentUser.zip);
    if (self.currentUser.stripeCustomerId) {
        // Charge customer
        [self chargeCustomer];
    } else {
        
        [self.currentUser createStripeCustomer:[NSNumber numberWithInteger:[self.expiryMonth.text integerValue]] expiryYear:[NSNumber numberWithInteger:[self.expiryYear.text integerValue]] number:self.creditCardTextField.text securityCode:self.csvTextField.text onLoad:^(StripeResponse *token) {
            [self saveContext];
            
            // Charge customer
            [self chargeCustomer];
        } onError:^(NSError *error) {
            DLog(@"failure %@", error);
            [SVProgressHUD showErrorWithStatus:[error description]];
        }];
    }
}

- (void)chargeCustomer {
    Order *order = [self buildOrder];
    [self.currentUser chargeCustomer:order onLoad:^(StripeResponse *token) {
        DLog(@"Success charging customer");
        order.stripeTransactionId = token.token;
        order.status = @"PAID";
        [RestUser order:order onLoad:^(RestOrder *restOrder) {
            DLog(@"Success creating order");
            [order setManagedObjectWithIntermediateObject:restOrder];
            [self saveContext];
            [SVProgressHUD dismiss];
            [((OrderController *)self.scrollView.delegate) performSegueWithIdentifier:@"ShowReceipt" sender:order];
        } onError:^(NSString *error) {
            DLog(@"failure %@", error);
            [SVProgressHUD showErrorWithStatus:error];
        }];
        
    } onError:^(NSError *error) {
        DLog(@"failure %@", error);
        [SVProgressHUD showErrorWithStatus:[error description]];
    }];

}


- (Order *)buildOrder {
    
    Order *order = [NSEntityDescription insertNewObjectForEntityForName:@"Order"
                                                 inManagedObjectContext:self.managedObjectContext];
    
    DLog(@"quantity %d", selectedQuantity);
    order.totalAmountCents = [NSNumber numberWithInteger:amountInCents];
    order.status = @"IN_PROGRESS";
    order.quantity = [NSNumber numberWithInteger:selectedQuantity];
    order.sku = [self skuForQuality];
    order.name = self.currentUser.name;
    order.address1 = self.currentUser.address1;
    order.address2 = self.currentUser.address2;
    order.city = self.currentUser.city;
    order.zip = self.currentUser.zip;
    order.state = self.currentUser.state;
    order.country = self.currentUser.country;
    order.stripeCustomerId = self.currentUser.stripeCustomerId;
    return order;
}

- (NSString *)skuForQuality {
    NSString *out;
    switch (selectedQuality) {
        case 0:
            out = @"REGULAR";
            break;
            
        case 1:
            out = @"PREMIUM";
        default:
            break;
    }
    return out;
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
