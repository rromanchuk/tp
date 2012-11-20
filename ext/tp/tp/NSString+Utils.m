//
//  NSString+Utils.m
//  tp
//
//  Created by Ryan Romanchuk on 11/20/12.
//
//

#import "NSString+Utils.h"

@implementation NSString (Utils)
- (BOOL)isEmpty {
    return self == nil
    || ([self respondsToSelector:@selector(length)]
        && [(NSData *)self length] == 0)
    || ([self respondsToSelector:@selector(count)]
        && [(NSArray *)self count] == 0);
}
@end
