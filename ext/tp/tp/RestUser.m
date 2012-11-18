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
#import "Order+Manage.h"
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


+ (void)order:(Order *)order
                    onLoad:(void (^)(RestOrder *restOrder))onLoad
                   onError:(void (^)(NSString *error))onError {
    
    RestClient *restClient = [RestClient sharedClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", order.name], @"order[name]",
                                   [NSString stringWithFormat:@"%@", order.address1], @"order[address1]",
                                   [NSString stringWithFormat:@"%@", order.address2], @"order[address2]",
                                   [NSString stringWithFormat:@"%@", order.stripeTransactionId], @"order[stripe_transaction_id]",
                                   [NSString stringWithFormat:@"%@", order.stripeCustomerId], @"order[stripe_customer_id]",
                                   [NSString stringWithFormat:@"%@", order.city], @"order[city]",
                                   [NSString stringWithFormat:@"%@", order.zip], @"order[zip]",
                                   [NSString stringWithFormat:@"%@", order.state], @"order[state]",
                                   [NSString stringWithFormat:@"%@", order.country], @"order[country]",
                                   [NSString stringWithFormat:@"%@", order.sku], @"order[sku]",
                                   [NSString stringWithFormat:@"%@", order.totalAmountCents], @"order[total_amount_cents]",
                                   [NSString stringWithFormat:@"%@", order.quantity], @"order[quantity]", nil];
    NSMutableURLRequest *request = [restClient requestWithMethod:@"POST"
                                                            path:ORDER
                                                      parameters:params];
    
    DLog(@"LOGIN REQUEST is %@ with params %@", request, params);
    DLog(@"params %@", params)
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
                                                                                            DLog(@"JSON: %@", JSON);
                                                                                            RestOrder *restOrder = [RestOrder objectFromJSONObject:JSON mapping:[RestOrder mapping]];
                                                                                            onLoad(restOrder);

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
