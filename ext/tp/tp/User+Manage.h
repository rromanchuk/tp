//
//  User+Manage.h
//  tp
//
//  Created by Ryan Romanchuk on 9/23/12.
//
//
#import "User.h"

@interface User (Manage)
+ (User *)currentUser:(NSManagedObjectContext *)managedContext;
- (void)createStripeCustomer;
- (void)chargeCustomer:(NSNumber *)amountInCents;
@end
