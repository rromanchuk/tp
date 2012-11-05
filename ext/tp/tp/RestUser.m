//
//  User.m
//  tp
//
//  Created by Ryan Romanchuk on 6/2/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import "RestUser.h"
#import "KeychainItemWrapper.h"
#import "AFJSONRequestOperation.h"
#import "Stripe.h"
#import "Config.h"
#import "RestClient.h"

static RestUser *_currentUser = nil;
static NSString *ORDER = @"orders/";

@implementation RestUser


+ (void)order:(User *)user
                    onLoad:(void (^)(id object))onLoad
                   onError:(void (^)(NSString *error))onError {
    
    RestClient *restClient = [RestClient sharedClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.name, @"name", user.address1, @"address1", user.address2, @"address2", user.city, @"city", user.state, @"state", user.zip, @"zip", user.country, @"country", nil];
    NSMutableURLRequest *request = [restClient requestWithMethod:@"POST"
                                                            path:ORDER
                                                      parameters:params];
    DLog(@"LOGIN REGUEST is %@", request);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
                                                                                            DLog(@"JSON: %@", JSON);
//                                                                                            RestUser *user = [RestUser objectFromJSONObject:JSON mapping:[RestUser mapping]];
//                                                                                            if (onLoad)
//                                                                                                onLoad(user);
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
//                                                                                            NSString *publicMessage = [RestObject processError:error for:@"LOGIN_USER_WITH_EMAIL" withMessageFromServer:[JSON objectForKey:@"message"]];
//                                                                                            if (onError)
//                                                                                                onError(publicMessage);
                                                                                        }];
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [operation start];
}



-(NSString *) description {
    return [NSString stringWithFormat:@"EMAIL: %@\nNAME: %@\nADDRESS: %@\nCITY: %@\nSTATE: %@\nZIP: %@\nCOUNTRY: %@\nCUSTOMER_ID: %@",
            self.email, self.name, self.address1, self.city, self.state, self.zip, self.country, self.stripeCustomerId];
}


@end
