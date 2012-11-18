//
//  RestOrder.m
//  tp
//
//  Created by Ryan Romanchuk on 11/18/12.
//
//

#import "RestOrder.h"

@implementation RestOrder

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
            @"totalAmountCents", @"total_amount_cents",
            @"status", @"status",
            @"stripeTransactionId", @"stripe_transaction_id",
            @"stripeCustomerId", @"stripe_customer_id",
            @"quantity", @"quantity",
            @"sku", @"sku",
            [NSDate mappingWithKey:@"createdAt"
                  dateFormatString:@"yyyy-MM-dd'T'hh:mm:ssZ"], @"created_at",
            nil];
    
}

@end
