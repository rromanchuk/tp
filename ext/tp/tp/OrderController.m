//
//  ViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "OrderController.h"
#import "PastOrdersViewController.h"
#import "UIBarButtonItem+Borderless.h"
#import "User+Manage.h"
#import "Stripe.h"
#import "Config.h"
#import "RestUser.h"
#import "SVProgressHUD.h"
#import "NSString+Utils.h"


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
    UIImage *gearImage = [UIImage imageNamed:@"gear.png"];
    UIBarButtonItem *configButton = [UIBarButtonItem barItemWithImage:gearImage target:self action:@selector(didTapConfig:)];
   
    self.navigationController.navigationItem.rightBarButtonItem = configButton;
    self.navigationItem.rightBarButtonItem = configButton;
    self.navigationItem.title = @"Tap on the type of roll you want.";
   
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Regular" size:18.0], UITextAttributeFont, nil];
	// Do any additional setup after loading the view, typically from a nib.
    
        
    self.qtyTable.hidden = true;
    self.qtyTable.backgroundColor = [UIColor blackColor];
    
    self.qtyButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:35.0];
    [self.qtyButton setTitle:@"6 Rolls" forState:UIControlStateNormal];
    
    
    self.premiumButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    [self didTapRegular:self];
    self.regularButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];

    
    self.orderButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    [self.orderButton setTitle:@"$4" forState:UIControlStateNormal];
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [FacebookHelper shared].delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowReceipt"]){
        NSLog(@"In prepare for segue");
        ShowReceiptViewController *vc = (ShowReceiptViewController *)segue.destinationViewController;
        vc.delegate = self;
        vc.order = (Order *)sender;
    } else if ([[segue identifier] isEqualToString:@"MyOrders"]) {
        PastOrdersViewController *vc = (PastOrdersViewController *)segue.destinationViewController;
        vc.currentUser = self.currentUser;
        
    } else if ([[segue identifier] isEqualToString:@"OrderForm"]) {
        OrderFormViewController *vc = (OrderFormViewController *)((UINavigationController *)segue.destinationViewController).topViewController;
        vc.currentUser = self.currentUser;
        vc.delegate = self;
        vc.fromConfig = self.fromConfig;
        vc.managedObjectContext = self.managedObjectContext;
    }
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

- (void)setupView {
    DLog(@"selected quantity %d", selectedQuantity);
    switch (selectedQuantity) {
        case RollQuantityType6:
            [self.qtyButton setTitle:@"6 Rolls" forState:UIControlStateNormal];
            [self.regularButton setTitle:@"$6" forState:UIControlStateNormal];
            [self.premiumButton setTitle:@"$9" forState:UIControlStateNormal];
            if (selectedQuality == RollQualityTypePremium) {
                [self.orderButton setTitle:@"$9" forState:UIControlStateNormal];
                amountInCents = 900;
            } else {
                [self.orderButton setTitle:@"$6" forState:UIControlStateNormal];
                amountInCents = 600;
            }
            break;
        case RollQuantityType12:
            [self.qtyButton setTitle:@"12 Rolls" forState:UIControlStateNormal];
            [self.regularButton setTitle:@"$10" forState:UIControlStateNormal];
            [self.premiumButton setTitle:@"$15" forState:UIControlStateNormal];
            if (selectedQuality == RollQualityTypePremium) {
                [self.orderButton setTitle:@"$15" forState:UIControlStateNormal];
                amountInCents = 1500;
            } else {
                [self.orderButton setTitle:@"$10" forState:UIControlStateNormal];
                amountInCents = 1000;
            }

            break;
            
        case RollQuantityType24:
            [self.qtyButton setTitle:@"24 Rolls" forState:UIControlStateNormal];
            [self.regularButton setTitle:@"$18" forState:UIControlStateNormal];
            [self.premiumButton setTitle:@"$27" forState:UIControlStateNormal];
            if (selectedQuality == RollQualityTypePremium) {
                [self.orderButton setTitle:@"$27" forState:UIControlStateNormal];
                amountInCents = 2700;
            } else {
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
    self.premiumButton.alpha = 0.4;
    self.regularButton.alpha = 1.0;
    selectedQuality = RollQualityTypeRegular;
    [self setupView];
}

- (IBAction)didTapPremium:(id)sender {
    ALog(@"did tap premium");
    self.regularButton.selected = NO;
    self.premiumButton.selected = YES;
    self.premiumButton.alpha = 1.0;
    self.regularButton.alpha = 0.4;
    selectedQuality = RollQualityTypePremium;
    [self setupView];
}


#pragma mark - User avents
- (IBAction)didTapCheckout:(id)sender {
    ALog(@"User's auth token is %@", [RestUser authToken]);
    self.fromConfig = NO;
    if ([RestUser authToken]) {
        
        if ([self.currentUser hasCustomerId] && [self.currentUser addressIsValid]) {
            [SVProgressHUD showWithStatus:@"Sending your order..."];
            [self sendOrder:self];
        } else {
            [self performSegueWithIdentifier:@"OrderForm" sender:self];
        }

    } else {
        [[FacebookHelper shared] login:self];
    }
}

- (IBAction)didTapConfig:(id)sender {
    if ([RestUser authToken]) {
        self.fromConfig = YES;
        [self performSegueWithIdentifier:@"OrderForm" sender:self];
    } else {
        [[FacebookHelper shared] login:self];
    }
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
    
    self.currentUser.country = @"United States";
    [self saveContext];
    
    DLog(@"name %@ and address %@ customerid %@ state %@  zip %@", self.currentUser.name, self.currentUser.address1, self.currentUser.stripeCustomerId, self.currentUser.state, self.currentUser.zip);
    if (self.currentUser.stripeCustomerId) {
        // Charge customer
        [self chargeCustomer];
    } else {
        [self performSegueWithIdentifier:@"OrderForm" sender:self];
    }
}
#pragma mark - OrderFormDelegate methods
- (void)newCustomerInformation:(NSString *)ccNumber year:(NSString *)year month:(NSString *)month code:(NSString *)code {
    [self.currentUser createStripeCustomer:[NSNumber numberWithInteger:[month integerValue]] expiryYear:[NSNumber numberWithInteger:[year integerValue]] number:ccNumber securityCode:code onLoad:^(StripeResponse *token) {
        [self saveContext];
        // Charge customer
        [self chargeCustomer];
        
    } onError:^(NSError *error) {
        DLog(@"failure %@", error);
        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:@"message"]];
    }];

}

- (void)didFinishFillingOutForm {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didCancelOrderForm {
    [self dismissModalViewControllerAnimated:YES];
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
            
            [self performSegueWithIdentifier:@"ShowReceipt" sender:order];
        } onError:^(NSString *error) {
            DLog(@"failure %@", error);
            [SVProgressHUD showErrorWithStatus:error];
        }];
        
    } onError:^(NSError *error) {
        DLog(@"failure %@", error);
        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:@"message"]];
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
    
    if (self.currentUser.shippingName.length) {
        order.name = self.currentUser.shippingName;
        order.address1 = self.currentUser.shippingAddress1;
        order.address2 = self.currentUser.shippingAddress2;
        order.city = self.currentUser.shippingCity;
        order.zip = self.currentUser.shippingZip;
        order.state = self.currentUser.shippingState;
    } else {
        order.name = self.currentUser.name;
        order.address1 = self.currentUser.address1;
        order.address2 = self.currentUser.address2;
        order.city = self.currentUser.city;
        order.zip = self.currentUser.zip;
        order.state = self.currentUser.state;
    }
   
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

#pragma mark - ReceiptDelegate methods
- (void)didDismissReceipt {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            //DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}


#pragma mark - FacebookHelperDelegate
- (void)userDidLogin {
    ALog(@"User logged in");
    [self saveContext];
    [self didTapCheckout:self];
}

- (void)didFailLogin:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
}

@end
