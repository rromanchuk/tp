//
//  Order.h
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * externalId;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *lineItems;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addLineItemsObject:(NSManagedObject *)value;
- (void)removeLineItemsObject:(NSManagedObject *)value;
- (void)addLineItems:(NSSet *)values;
- (void)removeLineItems:(NSSet *)values;

@end
