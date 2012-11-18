//
//  RestOrder.h
//  tp
//
//  Created by Ryan Romanchuk on 11/18/12.
//
//

#import <UIKit/UIKit.h>
#import "RestObject.h"
#import "RestUser.h"

@interface RestOrder : RestObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSDate *createdAt;

+ (NSDictionary *)mapping;

@end
