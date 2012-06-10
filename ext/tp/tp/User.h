//
//  User.h
//  tp
//
//  Created by Ryan Romanchuk on 6/2/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong) NSString *name;
@property (strong) NSString *address;
@property (strong) NSString *address1;
@property (strong) NSString *city; 
@property (strong) NSString *state; 
@property (strong) NSString *zip; 
@property (strong) NSString *country;
@property (strong) NSString *authenticationToken;
@property (strong) NSString *email;
@property (strong) NSUserDefaults *prefs; 

- (void)save:(void (^)(id object))onLoad
     onError:(void (^)(NSString *error))onError;
- (bool)isAuthenticated;
- (void)save;
+ (User *)currentUser;
+ (void)setCurrentUser:(User *)user;


@end
