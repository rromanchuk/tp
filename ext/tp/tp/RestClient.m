//
//  RestClient.m
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import "RestClient.h"
#import "Config.h"

@implementation RestClient

+ (RestClient *)sharedClient
{
    static dispatch_once_t pred;
    static RestClient *_sharedClient;
    
    dispatch_once(&pred, ^{
        _sharedClient = [[RestClient alloc] initWithBaseURL:[NSURL URLWithString:[Config sharedConfig].baseURL]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    
    if (self) {
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

@end
