//
//  LineItem+Manage.h
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import "LineItem.h"
#import "RestObject.h"
#import "RestLineItem.h"
@interface LineItem (Manage)

+ (LineItem *)lineItemWithRestLineItem:(RestLineItem *)restLineItem
                inManagedObjectContext:(NSManagedObjectContext *)context;

- (void)setManagedObjectWithIntermediateObject:(RestObject *)intermediateObject;
@end
