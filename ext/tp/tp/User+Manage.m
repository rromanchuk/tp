//
//  User+Manage.m
//  tp
//
//  Created by Ryan Romanchuk on 9/23/12.
//
//

#import "User+Manage.h"
#import "Stripe.h"
#import "Config.h"
@implementation User (Manage)

+ (User *)currentUser:(NSManagedObjectContext *)managedContext {
    User *user;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSError *error = nil;
    NSArray *users = [managedContext executeFetchRequest:request error:&error];
    //error handling goes here
    
    //more error handling here
    if ([users count] > 0) {
        user = [users lastObject];
    } else {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                             inManagedObjectContext:managedContext];
    }
    return user;
}

- (void)createStripeCustomer {
    StripeConnection *stripe = [StripeConnection connectionWithSecretKey:[Config sharedConfig].stripeSecret];
    StripeCard *card =  [[StripeCard alloc] init];
    card.number =       @"4111111111111111";
    card.name =         @"Bob Dylan";
    card.securityCode = @"010";
    card.expiryMonth =  [NSNumber numberWithInteger:2];
    card.expiryYear =   [NSNumber numberWithInteger:2014];
    [stripe createCustomerWithCard:card
                   withDescription:self.name
                           success:^(StripeResponse *token)
     {
         NSLog(@"Customer created successfully");
         self.stripeCustomerId = token.token;
         /* handle success */
     }
                             error:^(NSError *error)
     {
         NSLog(@"Customer creation failed %@", error);
         /* handle failure */
     }];

}

- (void)chargeCustomer:(NSNumber *)amountInCents {
    StripeConnection *stripe = [StripeConnection connectionWithSecretKey:[Config sharedConfig].stripeSecret];
    StripeCustomer *customer = [[StripeCustomer alloc] init];
    customer.token = self.stripeCustomerId;
    [stripe performRequestWithCustomer:customer
                         amountInCents:amountInCents
                               success:^(StripeResponse *token)
     {
         NSLog(@"Successfully charged customer");
     }
                                 error:^(NSError *error)
     {
         NSLog(@"Failed to charge customer %@", error);
     }];
    
}

- (void)createOrder:(NSManagedObjectContext *)managedContext  {
    Order *order = [NSEntityDescription insertNewObjectForEntityForName:@"Order"
                                                        inManagedObjectContext:managedContext];
    
}


@end
