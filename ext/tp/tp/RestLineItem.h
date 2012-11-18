//
//  RestLineItem.h
//  tp
//
//  Created by Ryan Romanchuk on 11/18/12.
//
//

#import "RestObject.h"

@interface RestLineItem : RestObject

@property NSInteger quantity;
@property NSString *sku;

+ (NSDictionary *)mapping;

@end
