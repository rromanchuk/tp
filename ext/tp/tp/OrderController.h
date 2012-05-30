//
//  ViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong) IBOutlet UINavigationBar *navigationBar;
@property (strong) IBOutlet UIButton *regularButton; 
@property (strong) IBOutlet UIButton *premiumButton;
@property (strong) IBOutlet UIButton *orderButton; 
@property (strong) IBOutlet UIButton *qtyButton;
@property (strong) IBOutlet UIButton *qtyButtonSmall;

//scroll view
@property (strong) IBOutlet UIScrollView *scrollView;
//Table properties
@property (strong) IBOutlet UITableView *qtyTable;

//Form
@property (strong) IBOutlet UILabel *nameLabel;
@property (strong) IBOutlet UITextField *nameTextField;
@property (strong) IBOutlet UILabel *addressLabel;
@property (strong) IBOutlet UILabel *cityLabel;
@property (strong) IBOutlet UILabel *stateLabel;
@property (strong) IBOutlet UILabel *zipLabel;
@property (strong) IBOutlet UILabel *helperText;

//Checkout
@property (strong) IBOutlet UILabel *thatsItLabel;
@property (strong) IBOutlet UILabel *deliveryEst;
@property (strong) IBOutlet UIButton *cancelOrder;

@property BOOL isOnCheckout;
@property (strong) UITextField *activeField;

- (void)config;
- (IBAction)qtyChange:(id)sender;
- (IBAction)scrollToCheckout:(id)sender;
- (IBAction)scrollToTop:(id)sender;
- (IBAction)removeKeyboard;

@end
