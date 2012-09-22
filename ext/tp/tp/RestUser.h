//
//  User.h
//  tp
//
//  Created by Ryan Romanchuk on 6/2/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestUser : NSObject
@property (strong) NSString *name;
@property (strong) NSString *address;
@property (strong) NSString *address1;
@property (strong) NSString *city; 
@property (strong) NSString *state; 
@property (strong) NSString *zip; 
@property (strong) NSString *country;
@property (strong) NSString *email;
@property (strong) NSUserDefaults *prefs; 
@property (strong) NSString *stripeCardToken;
@property (strong) NSString *stripeCustomerId; 

- (void)save:(void (^)(id object))onLoad
     onError:(void (^)(NSString *error))onError;
- (void)save;
- (void)createStripeCustomer;
- (void)chargeCustomer:(NSNumber *)amountInCents;
- (bool)hasCustomerObject;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)user;


@end
