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
            [NSDate mappingWithKey:@"createdAt"
                  dateFormatString:@"yyyy-MM-dd'T'hh:mm:ssZ"], @"created_at",
            nil];
    
}

@end
