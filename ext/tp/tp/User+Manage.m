//
//  User+Manage.m
//  tp
//
//  Created by Ryan Romanchuk on 9/23/12.
//
//

#import "User+Manage.h"
#import "Config.h"
#import "RestOrder.h"
#import "Order+Manage.h"
@implementation User (Manage)

+ (User *)currentUser:(NSManagedObjectContext *)managedContext {
    User *user;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSError *error = nil;
    NSArray *users = [managedContext executeFetchRequest:request error:&error];
    //error handling goes here
    
    //more error handling here
    if ([users count] == 1) {
        DLog(@"found one user");
        user = [users lastObject];
    } else if ([users count] == 0) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                             inManagedObjectContext:managedContext];
    }
    return user;
}

+ (User *)userWithRestUser:(RestUser *)restUser
    inManagedObjectContext:(NSManagedObjectContext *)context {
    
    User *user;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"externalId = %@", [NSNumber numberWithInt:restUser.externalId]];
    
    NSError *error = nil;
    NSArray *users = [context executeFetchRequest:request error:&error];
    
    if (!users || ([users count] > 1)) {
        // handle error
    } else if (![users count]) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                             inManagedObjectContext:context];
        
        [user setManagedObjectWithIntermediateObject:restUser];
        
    } else {
        user = [users lastObject];
        [user setManagedObjectWithIntermediateObject:restUser];
    }
    return user;
}

- (void)setManagedObjectWithIntermediateObject:(RestObject *)intermediateObject {
    RestUser *restUser = (RestUser *) intermediateObject;
    self.name = restUser.name;
    self.address1 = restUser.address1;
    self.address2 = restUser.address2;
    self.city = restUser.city;
    self.state = restUser.state;
    self.country = restUser.country;
    self.zip = restUser.zip;
    self.stripeCustomerId = restUser.stripeCustomerId;
    self.externalId = [NSNumber numberWithInteger:restUser.externalId];
    
    // Add comments
    for (RestOrder *restOrder in restUser.orders) {
        [self addOrdersObject:[Order orderWithRestOrder:restOrder inManagedObjectContext:self.managedObjectContext]];
    }

}

- (void)createStripeCustomer:(NSNumber *)expiryMonth
                  expiryYear:(NSNumber *)expiryYear
                      number:(NSString *)number
                securityCode:(NSString *)securityCode
                      onLoad:(void (^)(StripeResponse *token))onLoad
                     onError:(void (^)(NSError *error))onError
{
    StripeConnection *stripe = [StripeConnection connectionWithSecretKey:[Config sharedConfig].stripeSecret];
    StripeCard *card =  [[StripeCard alloc] init];
    card.number =       number;
    card.name =         self.name;
    card.securityCode = securityCode;
    card.expiryMonth =  expiryMonth;
    card.expiryYear =   expiryYear;
    [stripe createCustomerWithCard:card
                   withDescription:self.name
                           success:^(StripeResponse *token)
     {
         NSLog(@"Customer created successfully %@", token);
         self.stripeCustomerId = token.token;
         onLoad(token);
         /* handle success */
         
     }
                             error:^(NSError *error)
     {
         NSLog(@"Customer creation failed %@", error);
         onError(error);
         /* handle failure */
     }];

}

- (void)chargeCustomer:(NSNumber *)amountInCents
                onLoad:(void (^)(StripeResponse *token))onLoad
               onError:(void (^)(NSError *error))onError {
    StripeConnection *stripe = [StripeConnection connectionWithSecretKey:[Config sharedConfig].stripeSecret];
    StripeCustomer *customer = [[StripeCustomer alloc] init];
    customer.token = self.stripeCustomerId;
    [stripe performRequestWithCustomer:customer
                         amountInCents:amountInCents
                               success:^(StripeResponse *token)
     {
         NSLog(@"Successfully charged customer");
         onLoad(token);
     }
                                 error:^(NSError *error)
     {
         NSLog(@"Failed to charge customer %@", error);
         onError(error);
     }];
    
}

- (void)createOrder:(NSManagedObjectContext *)managedContext  {
    Order *order = [NSEntityDescription insertNewObjectForEntityForName:@"Order"
                                                        inManagedObjectContext:managedContext];
    
}

- (BOOL)hasCustomerId {
    if (self.stripeCustomerId)
        return YES;
    
    return NO;
}

- (BOOL)addressIsValid {
    if (self.name && self.address1 && self.city && self.state && self.zip)
        return YES;
    
    return NO;
        
}


@end
