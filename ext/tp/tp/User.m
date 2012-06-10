//
//  User.m
//  tp
//
//  Created by Ryan Romanchuk on 6/2/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import "User.h"
#import "KeychainItemWrapper.h"
#import "AFJSONRequestOperation.h"

static User *_currentUser = nil;

@implementation User

@synthesize name; 
@synthesize address;
@synthesize address1;
@synthesize city;
@synthesize state;
@synthesize zip;
@synthesize country;
@synthesize authenticationToken; 
@synthesize email;
@synthesize prefs;

- (id)init {
    if (self = [super init]) {
        NSLog(@"Initializing user.");
        self.prefs = [NSUserDefaults standardUserDefaults];
        self.authenticationToken = [self.prefs stringForKey:@"authenticationToken"];
        self.name = [self.prefs stringForKey:@"name"]; 
        self.address = [self.prefs stringForKey:@"address"];
        self.address1 = [self.prefs stringForKey:@"address1"]; 
        self.city = [self.prefs stringForKey:@"city"];
        self.state = [self.prefs stringForKey:@"state"]; 
        self.zip = [self.prefs stringForKey:@"zip"]; 
        self.country = [self.prefs stringForKey:@"country"];
        self.email = [self.prefs stringForKey:@"email"];
    }
    return self; 
}

- (void)save {
    NSLog(@"Saving user model.");
    [self.prefs setValue:self.name forKey:@"name"];
    [self.prefs setValue:self.address1 forKey:@"address1"];
    [self.prefs setValue:self.address forKey:@"address"];
    [self.prefs setValue:self.city forKey:@"city"];
    [self.prefs setValue:self.state forKey:@"state"];
    [self.prefs setValue:self.zip forKey:@"zip"];
    [self.prefs setValue:self.country forKey:@"country"];
    [self.prefs setValue:self.email forKey:@"email"];
    [self.prefs synchronize];
    
}


- (void)save:(void (^)(id object))onLoad
       onError:(void (^)(NSString *error))onError {
    NSURL *url = [NSURL URLWithString:@"tp4.me/users"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; 
    request.HTTPMethod = @"POST";
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Name: %@ %@", [JSON valueForKeyPath:@"first_name"], [JSON valueForKeyPath:@"last_name"]);
    } failure:nil]; 
    [operation start];
}

- (bool)isAuthenticated {
    NSLog(@"Authentication Token: %@", self.authenticationToken);
    if (self.authenticationToken) {
        return YES;
    } else {
        return NO;
    }
}

+ (User *)currentUser
{
    return _currentUser;
}

+ (void)setCurrentUser:(User *)user
{
    _currentUser = user;
    NSLog(@"setCurrentUser: ");
}

-(NSString *) description {
    return [NSString stringWithFormat:@"NAME: %@\nADDRESS: %@\n",
            self.name, self.address];
}


@end
