//
//  User+Manage.h
//  tp
//
//  Created by Ryan Romanchuk on 9/23/12.
//
//
#import "User.h"
#import "Stripe.h"

@interface User (Manage)
+ (User *)currentUser:(NSManagedObjectContext *)managedContext;

- (void)createStripeCustomer:(NSNumber *)expiryMonth
                  expiryYear:(NSNumber *)expiryYear
                      number:(NSString *)number
                securityCode:(NSString *)securityCode
                      onLoad:(void (^)(StripeResponse *token))onLoad
                     onError:(void (^)(NSError *error))onError;


- (void)chargeCustomer:(NSNumber *)amountInCents
                onLoad:(void (^)(StripeResponse *token))onLoad
               onError:(void (^)(NSError *error))onError;
@end
