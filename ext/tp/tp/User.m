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
#import "Stripe.h"
#import "Config.h"
static User *_currentUser = nil;

@implementation User

@synthesize name; 
@synthesize address;
@synthesize address1;
@synthesize city;
@synthesize state;
@synthesize zip;
@synthesize country;
@synthesize stripeCardToken;
@synthesize stripeCustomerId; 
@synthesize email;
@synthesize prefs;

- (id)init {
    if (self = [super init]) {
        NSLog(@"Initializing user.");
        self.prefs = [NSUserDefaults standardUserDefaults];
        self.stripeCustomerId = [self.prefs stringForKey:@"stripeCustomerId"];
        self.name = [self.prefs stringForKey:@"name"];
        self.email = [self.prefs stringForKey:@"email"];
        self.address = [self.prefs stringForKey:@"address"];
        self.address1 = [self.prefs stringForKey:@"address1"]; 
        self.city = [self.prefs stringForKey:@"city"];
        self.state = [self.prefs stringForKey:@"state"]; 
        self.zip = [self.prefs stringForKey:@"zip"]; 
        self.country = [self.prefs stringForKey:@"country"];
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
    [self.prefs setValue:self.stripeCardToken forKey:@"stripeCardToken"];
    [self.prefs setValue:self.stripeCustomerId forKey:@"stripeCustomerId"];
    [self.prefs synchronize];
    
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
    [self save];
}

- (bool)hasCustomerObject {
    if(self.stripeCustomerId) {
        return YES;
    } else {
        return NO;
    }
}

- (void)save:(void (^)(id object))onLoad
       onError:(void (^)(NSString *error))onError {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tp4.me/api/users?access_token=%@", @"fdj"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; 
    request.HTTPMethod = @"POST";
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Name: %@ %@", [JSON valueForKeyPath:@"first_name"], [JSON valueForKeyPath:@"last_name"]);
    } failure:nil]; 
    [operation start];
}

+ (User *)currentUser
{
    if (_currentUser) {
        return _currentUser;
    } else {
        User *user = [[User alloc] init];
        [User setCurrentUser:user];
        return _currentUser;
    }
}

+ (void)setCurrentUser:(User *)user
{
    _currentUser = user;
    NSLog(@"setCurrentUser: ");
}

-(NSString *) description {
    return [NSString stringWithFormat:@"EMAIL: %@\nNAME: %@\nADDRESS: %@\nCITY: %@\nSTATE: %@\nZIP: %@\nCOUNTRY: %@\nCUSTOMER_ID: %@",
            self.email, self.name, self.address, self.city, self.state, self.zip, self.country, self.stripeCustomerId];
}


@end
