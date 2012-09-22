//
//  ViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowReceiptViewController.h"
#import "User.h"
@protocol ReceiptDelegate;
@interface OrderController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, ReceiptDelegate> {
    NSString *option1; 
    NSString *option2; 
    NSString *option3;
    NSString *option4;
}

@property (weak) IBOutlet UINavigationBar *navigationBar;
@property (weak) IBOutlet UIBarButtonItem *rightBarButton;
@property (weak) IBOutlet UIButton *regularButton; 
@property (weak) IBOutlet UIButton *premiumButton;
@property (weak) IBOutlet UIButton *orderButton; 
@property (weak) IBOutlet UIButton *qtyButton;
@property (weak) IBOutlet UIButton *qtyButtonSmall;

//scroll view
@property (weak) IBOutlet UIScrollView *scrollView;
//Table properties
@property (weak) IBOutlet UITableView *qtyTable;

//Form
@property (weak) IBOutlet UILabel *nameLabel;
@property (weak) IBOutlet UITextField *nameTextField;

@property (weak) IBOutlet UILabel *emailLabel; 
@property (weak) IBOutlet UITextField *emailTextField;

@property (weak) IBOutlet UILabel *addressLabel;
@property (weak) IBOutlet UITextField *addressTextField;

@property (weak) IBOutlet UILabel *address1Label;
@property (weak) IBOutlet UITextField *address1Textfield;

@property (weak) IBOutlet UILabel *cityLabel;
@property (weak) IBOutlet UITextField *cityTextField;

@property (weak) IBOutlet UILabel *stateLabel;
@property (weak) IBOutlet UITextField *stateTextField;

@property (weak) IBOutlet UILabel *zipLabel;
@property (weak) IBOutlet UITextField *zipTextField;

@property (weak) IBOutlet UILabel *helperText;

//Checkout
@property (weak) IBOutlet UILabel *thatsItLabel;
@property (weak) IBOutlet UILabel *deliveryEst;
@property (weak) IBOutlet UIButton *cancelOrder;

@property BOOL isOnCheckout;
@property (weak) UITextField *activeField;

@property (weak) IBOutlet UIButton *test;


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) User *currentUser;

- (void)config;
- (IBAction)qtyChange:(id)sender;
- (IBAction)scrollToCheckout:(id)sender;
- (IBAction)scrollToTop:(id)sender;
- (IBAction)removeKeyboard;
- (IBAction)sendOrder:(id)sender;
- (void)didDismissReceipt;
@end

