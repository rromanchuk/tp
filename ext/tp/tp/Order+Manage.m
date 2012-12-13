//
//  Order+Manage.m
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import "Order+Manage.h"
@implementation Order (Manage)

+ (Order *)orderWithRestOrder:(RestOrder *)restOrder
    inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Order *order;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Order"];
    request.predicate = [NSPredicate predicateWithFormat:@"externalId = %@", [NSNumber numberWithInt:restOrder.externalId]];
    
    NSError *error = nil;
    NSArray *orders = [context executeFetchRequest:request error:&error];
    
    if (!orders || ([orders count] > 1)) {
        // handle error
    } else if (![orders count]) {
        order = [NSEntityDescription insertNewObjectForEntityForName:@"Order"
                                             inManagedObjectContext:context];
        
        [order setManagedObjectWithIntermediateObject:restOrder];
        
    } else {
        order = [orders lastObject];
        [order setManagedObjectWithIntermediateObject:restOrder];
    }
    return order;
}

- (void)setManagedObjectWithIntermediateObject:(RestObject *)intermediateObject {
    RestOrder *restOrder = (RestOrder *) intermediateObject;
    self.name = restOrder.name;
    self.address1 = restOrder.address1;
    self.address2 = restOrder.address2;
    self.city = restOrder.city;
    self.state = restOrder.state;
    self.country = restOrder.country;
    self.zip = restOrder.zip;
    self.status = restOrder.status;
    self.stripeTransactionId = restOrder.stripeTransactionId;
    self.stripeCustomerId = restOrder.stripeCustomerId;
    self.totalAmountCents = [NSNumber numberWithInteger:restOrder.totalAmountCents];
    self.externalId = [NSNumber numberWithInteger:restOrder.externalId];
    self.sku = restOrder.sku;
    self.quantity = [NSNumber numberWithInteger:restOrder.quantity];
    self.createdAt = restOrder.createdAt;
    // add line items
  
}

@end
