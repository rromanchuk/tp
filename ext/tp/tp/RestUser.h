//
//  User.h
//  tp
//
//  Created by Ryan Romanchuk on 6/2/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"
#import "User.h"

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
@property (strong) NSDate *createdAt;

@property (strong) NSSet *orders;

+ (NSDictionary *)mapping;
+ (void)order:(User *)user
       onLoad:(void (^)(User *user))onLoad
      onError:(void (^)(NSString *error))onError;


@end
