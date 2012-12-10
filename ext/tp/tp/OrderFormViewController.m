//
//  OrderFormViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 12/5/12.
//
//

#import "OrderFormViewController.h"
#import "NSString+Utils.h"
#import "PastOrdersViewController.h"

@interface OrderFormViewController ()

@end

@implementation OrderFormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
//                                 forBarMetrics:UIBarMetricsDefault];
//    }
//    
//    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ProximaNova-Regular" size:15.0], UITextAttributeFont, nil];
    
    [self.segmentControl addTarget:self action:@selector(didTapSegment:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Checkout form
    self.nameLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.address1Label.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.stateLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.cityLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.zipLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.creditCardLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.csvLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.expirationLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    self.orderCheckoutButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:20.0];

    self.helperText.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14.0];
    
    //Checkout
    if (self.fromConfig) {
        self.orderCheckoutButton.hidden = YES;
        self.doneButton.hidden = NO;
        self.thatsItLabel.hidden = self.deliveryEst.hidden = self.deliveryTruckImage.hidden = YES;


    } else {
        self.orderCheckoutButton.hidden = NO;
        self.doneButton.hidden = YES;
        self.thatsItLabel.hidden = self.deliveryEst.hidden = self.deliveryTruckImage.hidden = NO;
    }
    
    self.thatsItLabel.font = [UIFont fontWithName:@"ArvilSans" size:22.0];
    self.deliveryEst.font = [UIFont fontWithName:@"ArvilSans" size:20.0];
    self.isOnCheckout = NO;
    [self loadForm];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([[segue identifier] isEqualToString:@"MyOrders"]) {
        PastOrdersViewController *vc = (PastOrdersViewController *)segue.destinationViewController;
        vc.currentUser = self.currentUser;
        
    } 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)loadForm {
    DLog(@"name %@ and address %@ customerid %@ state %@  zip %@", self.currentUser.name, self.currentUser.address1, self.currentUser.stripeCustomerId, self.currentUser.state, self.currentUser.zip);
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.nameTextField.text = self.currentUser.name;
        self.address1TextField.text = self.currentUser.address1;
        self.cityTextField.text = self.currentUser.city;
        self.stateTextField.text = self.currentUser.state;
        self.zipTextField.text = self.currentUser.zip;
        self.nameTextField.placeholder = self.address1TextField.placeholder = self.cityTextField.placeholder = self.stateTextField.placeholder = self.zipTextField.placeholder = @"(required)";
    } else {
        self.nameTextField.text = self.currentUser.shippingName;
        self.address1TextField.text = self.currentUser.shippingAddress1;
        self.cityTextField.text = self.currentUser.shippingCity;
        self.stateTextField.text = self.currentUser.shippingState;
        self.zipTextField.text = self.currentUser.shippingState;
        
        self.nameTextField.placeholder = self.address1TextField.placeholder = self.cityTextField.placeholder = self.stateTextField.placeholder = self.zipTextField.placeholder = @"(optional)";
    }
   
    
    if ([self.currentUser.stripeCustomerId isEmpty] || !self.currentUser.stripeCustomerId) {
        ALog(@"Users has stripe customer");
        
        //[self.formView setFrame:CGRectMake(self.formView.frame.origin.x, self.formView.frame.origin.y, self.formView.frame.size.width, 293)];
        self.creditCardLabel.hidden = self.creditCardTextField.hidden = self.csvTextField.hidden = self.csvLabel.hidden = self.expirationLabel.hidden = self.expiryMonth.hidden = self.expiryYear.hidden = NO;
        self.lastFourLabel.hidden = YES;
        self.creditCardLabel.text = @"CREDIT CARD";
//        [self.orderCheckoutButton setFrame:CGRectMake(self.orderCheckoutButton.frame.origin.x, self.formView.frame.origin.y + self.formView.frame.size.height + 10, self.orderCheckoutButton.frame.size.width, self.orderCheckoutButton.frame.size.height)];
//        
//        [self.thatsItLabel setFrame:CGRectMake(self.thatsItLabel.frame.origin.x, self.formView.frame.origin.y + self.formView.frame.size.height + 10, self.thatsItLabel.frame.size.width, self.thatsItLabel.frame.size.height)];
//        
//        [self.deliveryEst setFrame:CGRectMake(self.deliveryEst.frame.origin.x, self.thatsItLabel.frame.origin.y + self.thatsItLabel.frame.size.height + 5, self.deliveryEst.frame.size.width, self.deliveryEst.frame.size.height)];
//        
//        [self.deliveryTruckImage setFrame:CGRectMake(self.deliveryTruckImage.frame.origin.x, self.thatsItLabel.frame.origin.y + self.thatsItLabel.frame.size.height + 5, self.deliveryTruckImage.frame.size.width, self.deliveryTruckImage.frame.size.height)];
        
    } else {
        
//        [self.formView setFrame:CGRectMake(self.formView.frame.origin.x, self.formView.frame.origin.y, self.formView.frame.size.width, self.stateTextField.frame.origin.y + self.stateTextField.frame.size.height + 10)];
        
//        [self.orderCheckoutButton setFrame:CGRectMake(self.orderCheckoutButton.frame.origin.x, self.formView.frame.origin.y + self.formView.frame.size.height + 10, self.orderCheckoutButton.frame.size.width, self.orderCheckoutButton.frame.size.height)];
        
//        [self.thatsItLabel setFrame:CGRectMake(self.thatsItLabel.frame.origin.x, self.formView.frame.origin.y + self.formView.frame.size.height + 10, self.thatsItLabel.frame.size.width, self.thatsItLabel.frame.size.height)];
//        
//        [self.deliveryEst setFrame:CGRectMake(self.deliveryEst.frame.origin.x, self.thatsItLabel.frame.origin.y + self.thatsItLabel.frame.size.height + 5, self.deliveryEst.frame.size.width, self.deliveryEst.frame.size.height)];
//        
//        [self.deliveryTruckImage setFrame:CGRectMake(self.deliveryTruckImage.frame.origin.x, self.thatsItLabel.frame.origin.y + self.thatsItLabel.frame.size.height + 5, self.deliveryTruckImage.frame.size.width, self.deliveryTruckImage.frame.size.height)];
        
        self.creditCardTextField.hidden = self.csvTextField.hidden = self.csvLabel.hidden = self.expirationLabel.hidden = self.expiryMonth.hidden = self.expiryYear.hidden = YES;
        self.creditCardLabel.text = @"Card on file";
        self.lastFourLabel.hidden = NO;
    }

    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *header = [UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 30);
//    UILabel *helperLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 40, 30)];
//    [header addSubview:helperLabel];
//    
//    return header;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - UITextFieldDelegate methods
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


- (BOOL)isValid {
    if ([self.nameTextField.text isEmpty] ) {
        ALog(@"no name");
        [SVProgressHUD showErrorWithStatus:@"You forgot your name!"];
        return NO;
    } else if (!self.address1TextField.text) {
        [SVProgressHUD showErrorWithStatus:@"You forgot your address!"];
        return NO;
    } else if (!self.cityTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"You forgot your city!"];
        return NO;
    } else if (!self.stateTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"You forgot your state!"];
        return NO;
    } else if (!self.zipTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"You forgot your zip!"];
        return NO;
    }
    
    if (!self.currentUser.stripeCustomerId) {
        if ([self.creditCardTextField.text isEmpty]) {
            [SVProgressHUD showErrorWithStatus:@"Hold your horses! You forgot your CreditCard!"];
            return NO;
        } else if ([self.expiryMonth.text isEmpty]) {
            [SVProgressHUD showErrorWithStatus:@"Hold your horses! You forgot your CreditCard!"];
            return NO;
        } else if ([self.expiryYear.text isEmpty]) {
            [SVProgressHUD showErrorWithStatus:@"Hold your horses! You forgot your CreditCard!"];
            return NO;
        }
    }
    
    return YES;
}



- (void)viewDidUnload {
    [self setOrderCheckoutButton:nil];
    [self setFormView:nil];
    [self setLastFourLabel:nil];
    [self setSegmentControl:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
}

- (IBAction)didTapCancel:(id)sender {
    [self.delegate didCancelOrderForm];
}

- (IBAction)didTapOrder:(id)sender {
    [SVProgressHUD showWithStatus:@"Sending your order..."];
    [self saveContext];
    if (self.creditCardTextField.text.length > 0) {
        [self.delegate newCustomerInformation:self.creditCardTextField.text year:self.expiryYear.text month:self.expiryMonth.text code:self.csvTextField.text];
    } else {
        [self.delegate didFinishFillingOutForm];
    }
    
}

- (IBAction)didTapDone:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.currentUser.name = self.nameTextField.text;
        self.currentUser.address1 = self.address1TextField.text;
        self.currentUser.city = self.cityTextField.text;
        self.currentUser.state = self.stateTextField.text;
        self.currentUser.zip = self.zipTextField.text;
    } else {
        self.currentUser.shippingName = self.nameTextField.text;
        self.currentUser.shippingAddress1 = self.address1TextField.text;
        self.currentUser.shippingCity = self.cityTextField.text;
        self.currentUser.shippingState = self.stateTextField.text;
        self.currentUser.shippingZip = self.zipTextField.text;
    }

    [self saveContext];
    [self.delegate didFinishFillingOutForm];
}


- (IBAction)didTapSegment:(id)sender {
    ALog(@"tapped segment");
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.currentUser.shippingName = self.nameTextField.text;
        self.currentUser.shippingAddress1 = self.address1TextField.text;
        self.currentUser.shippingCity = self.cityTextField.text;
        self.currentUser.shippingState = self.stateTextField.text;
        self.currentUser.shippingZip = self.zipTextField.text;
    } else {
        self.currentUser.name = self.nameTextField.text;
        self.currentUser.address1 = self.address1TextField.text;
        self.currentUser.city = self.cityTextField.text;
        self.currentUser.state = self.stateTextField.text;
        self.currentUser.zip = self.zipTextField.text;

    }
    [self loadForm];
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

@end
