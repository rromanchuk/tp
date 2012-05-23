//
//  ViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong) IBOutlet UINavigationBar *navigationBar;
@property (strong) IBOutlet UIButton *regularButton; 
@property (strong) IBOutlet UIButton *premiumButton;
@property (strong) IBOutlet UIButton *orderButton; 
@property (strong) IBOutlet UIButton *qtyButton;

//Table properties
@property (strong) IBOutlet UITableView *qtyTable;

- (void)config;
- (IBAction)qtyChange:(id)sender;

@end
