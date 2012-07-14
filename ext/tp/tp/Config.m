//
//  Config.m
//  tp
//
//  Created by Ryan Romanchuk on 6/16/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import "Config.h"

@implementation Config
@synthesize baseURL; 
@synthesize stripeKey; 
@synthesize stripeSecret;

- (id)init
{
    self = [super init];
    
    if (self) {
        NSString *configuration    = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];
        NSLog(@"CONFIG: %@", configuration);
        NSBundle *bundle           = [NSBundle mainBundle];
        NSDictionary *environments = [[NSDictionary alloc] initWithContentsOfFile:[bundle pathForResource:@"Environments" ofType:@"plist"]];
        NSDictionary *environment  = [environments objectForKey:configuration];
        self.baseURL        = [environment valueForKey:@"baseURL"];
        self.stripeKey      = [environment valueForKey:@"stripeKey"];
        self.stripeSecret   = [environment valueForKey:@"stripeSecret"];
    }
    
    return self;
}


+ (Config *)sharedConfig
{
    static dispatch_once_t pred;
    static Config *sharedConfig;
    
    dispatch_once(&pred, ^{
        sharedConfig = [[Config alloc] init];
    });
    
    return sharedConfig;
}

@end