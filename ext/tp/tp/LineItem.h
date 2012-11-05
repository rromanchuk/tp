//
//  LineItem.h
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Order;

@interface LineItem : NSManagedObject

@property (nonatomic, retain) NSNumber * externalId;
@property (nonatomic, retain) NSString * sku;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) Order *order;

@end
