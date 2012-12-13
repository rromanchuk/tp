//
//  PastOrdersViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 11/29/12.
//
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "User.h"
#import "Order+Manage.h"
#import "ShowReceiptViewController.h"

@interface PastOrdersViewController : CoreDataTableViewController <ReceiptDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) User *currentUser;

@end
