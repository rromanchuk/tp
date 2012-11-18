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
#import "RestOrder.h"

static NSString *ORDER = @"orders/";

@implementation RestUser

+ (NSDictionary *)mapping {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"externalId", @"id",
            @"name", @"name",
            @"address1", @"address1",
            @"address2", @"address2",
            @"city", @"city",
            @"state", @"state",
            @"country", @"country",
            @"zip", @"zip",
            [RestOrder mappingWithKey:@"orders" mapping:[RestOrder mapping]], @"orders",
            [NSDate mappingWithKey:@"createdAt"
                  dateFormatString:@"yyyy-MM-dd'T'hh:mm:ssZ"], @"created_at",
            nil];
    
}


+ (void)order:(User *)user
                    onLoad:(void (^)(User *user))onLoad
                   onError:(void (^)(NSString *error))onError {
    
    RestClient *restClient = [RestClient sharedClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.name, @"name", user.address1, @"address1", user.stripeCustomerId, @"stripe_customer_id", user.city, @"city", user.zip, @"zip", user.state, @"state", user.country, @"country", @"PREMIUM", @"sku", @"2", @"quantity", nil];
    NSMutableURLRequest *request = [restClient requestWithMethod:@"POST"
                                                            path:ORDER
                                                      parameters:params];
    
    DLog(@"LOGIN REQUEST is %@ with params %@", request, params);
    DLog(@"params %@", params)
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
                                                                                            DLog(@"JSON: %@", JSON);
                                                                                            User *user = [RestUser objectFromJSONObject:JSON mapping:[RestUser mapping]];
                                                                                            onLoad(user);

                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
//                                                                                            NSString *publicMessage = [RestObject processError:error for:@"LOGIN_USER_WITH_EMAIL" withMessageFromServer:[JSON objectForKey:@"message"]];
                                                                                            if (onError)
                                                                                                onError([error description]);
                                                                                        }];
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [operation start];
}



-(NSString *) description {
    return [NSString stringWithFormat:@"EMAIL: %@\nNAME: %@\nADDRESS: %@\nCITY: %@\nSTATE: %@\nZIP: %@\nCOUNTRY: %@\nCUSTOMER_ID: %@",
            self.email, self.name, self.address1, self.city, self.state, self.zip, self.country, self.stripeCustomerId];
}


@end
