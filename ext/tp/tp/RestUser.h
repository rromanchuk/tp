//
//  User.h
//  tp
//
//  Created by Ryan Romanchuk on 6/2/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"
#import "RestOrder.h"
#import "Order.h"
@interface RestUser : RestObject

@property (strong) NSString *name;
@property (strong) NSString *address1;
@property (strong) NSString *address2;
@property (strong) NSString *city; 
@property (strong) NSString *state; 
@property (strong) NSString *zip; 
@property (strong) NSString *country;
@property (strong) NSString *email;
@property (strong) NSString *stripeCardToken;
@property (strong) NSString *stripeCustomerId;
@property (strong) NSString *authenticationToken;

@property (strong) NSDate *createdAt;

@property (strong) NSSet *orders;

+ (NSDictionary *)mapping;

+ (void)order:(Order *)order
       onLoad:(void (^)(RestOrder *restOrder))onLoad
      onError:(void (^)(NSString *error))onError;

+ (void)create:(NSMutableDictionary *)parameters
        onLoad:(void (^)(RestUser *restUser))onLoad
       onError:(void (^)(NSError *error))onError;

+ (NSString *)authToken;
+ (void)setAuthToken:(NSString *)token;
+ (void)deleteAuthToken;
@end
