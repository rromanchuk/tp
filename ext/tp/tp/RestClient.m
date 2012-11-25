//
//  RestClient.m
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import "RestClient.h"
#import "Config.h"
#import "RestUser.h"
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

+ (NSMutableDictionary *)defaultParameters
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ([RestUser authToken]) {
        [dict setObject:[RestUser authToken] forKey:@"auth_token"];
    }
    return dict;
}

+ (NSMutableDictionary *)defaultParametersWithParams:(NSDictionary *)params
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self defaultParameters]];
    [dict addEntriesFromDictionary:params];
    return dict;
}

@end
