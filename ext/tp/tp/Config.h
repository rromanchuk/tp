//
//  Config.h
//  tp
//
//  Created by Ryan Romanchuk on 6/16/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
@interface Config : NSObject
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *stripeKey;
@property (nonatomic, strong) NSString *stripeSecret;
+ (Config *)sharedConfig;
@end
