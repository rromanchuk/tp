//
//  LineItem+Manage.m
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import "LineItem+Manage.h"

@implementation LineItem (Manage)

+ (LineItem *)lineItemWithRestLineItem:(RestLineItem *)restLineItem
       inManagedObjectContext:(NSManagedObjectContext *)context {
    
    LineItem *lineItem;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LineItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"externalId = %@", [NSNumber numberWithInt:restLineItem.externalId]];
    
    NSError *error = nil;
    NSArray *lineItems = [context executeFetchRequest:request error:&error];
    
    if (!lineItems || ([lineItems count] > 1)) {
        // handle error
    } else if (![lineItems count]) {
        lineItem = [NSEntityDescription insertNewObjectForEntityForName:@"LineItem"
                                              inManagedObjectContext:context];
        
        [lineItem setManagedObjectWithIntermediateObject:restLineItem];
        
    } else {
        lineItem = [lineItems lastObject];
        [lineItem setManagedObjectWithIntermediateObject:restLineItem];
    }
    return lineItem;
}


- (void)setManagedObjectWithIntermediateObject:(RestObject *)intermediateObject {
    RestLineItem *restLineItem = (RestLineItem *)intermediateObject;
    self.externalId = [NSNumber numberWithInteger:restLineItem.externalId];
    self.sku = restLineItem.sku;
    self.quantity = [NSNumber numberWithInteger:restLineItem.quantity];
}
@end
