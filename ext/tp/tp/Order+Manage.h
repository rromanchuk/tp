//
//  Order+Manage.h
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import "Order.h"
#import "RestObject.h"
#import "RestOrder.h"
@interface Order (Manage)
+ (Order *)orderWithRestOrder:(RestOrder *)restOrder inManagedObjectContext:(NSManagedObjectContext *)context;
- (void)setManagedObjectWithIntermediateObject:(RestObject *)intermediateObject;

@end
