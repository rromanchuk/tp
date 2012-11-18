//
//  Order.h
//  tp
//
//  Created by Ryan Romanchuk on 11/18/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSNumber * totalAmountCents;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * externalId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * stripeTransactionId;
@property (nonatomic, retain) NSString * sku;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSNumber * isPaid;
@property (nonatomic, retain) NSString * stripeCustomerId;
@property (nonatomic, retain) User *user;

@end
