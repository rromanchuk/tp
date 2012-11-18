//
//  Order.h
//  tp
//
//  Created by Ryan Romanchuk on 11/18/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LineItem, User;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSNumber * externalId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet *lineItems;
@property (nonatomic, retain) User *user;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addLineItemsObject:(LineItem *)value;
- (void)removeLineItemsObject:(LineItem *)value;
- (void)addLineItems:(NSSet *)values;
- (void)removeLineItems:(NSSet *)values;

@end
