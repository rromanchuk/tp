//
//  User.h
//  tp
//
//  Created by Ryan Romanchuk on 12/9/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Order;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * authenticationToken;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * externalId;
@property (nonatomic, retain) NSString * last4;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * stripeCardToken;
@property (nonatomic, retain) NSString * stripeCustomerId;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSString * shippingAddress1;
@property (nonatomic, retain) NSString * shippingAddress2;
@property (nonatomic, retain) NSString * shippingCity;
@property (nonatomic, retain) NSString * shippingState;
@property (nonatomic, retain) NSString * shippingZip;
@property (nonatomic, retain) NSString * shippingCountry;
@property (nonatomic, retain) NSString * shippingName;
@property (nonatomic, retain) NSSet *orders;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addOrdersObject:(Order *)value;
- (void)removeOrdersObject:(Order *)value;
- (void)addOrders:(NSSet *)values;
- (void)removeOrders:(NSSet *)values;

@end
