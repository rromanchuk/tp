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
@interface PastOrdersViewController : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) User *currentUser;

@end
