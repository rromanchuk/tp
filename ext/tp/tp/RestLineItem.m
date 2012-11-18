//
//  RestLineItem.m
//  tp
//
//  Created by Ryan Romanchuk on 11/18/12.
//
//

#import "RestLineItem.h"

@implementation RestLineItem

+ (NSDictionary *)mapping {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"externalId", @"id",
            @"sku", @"sku",
            @"quantity", @"quantity",
            nil];
    
}

@end
