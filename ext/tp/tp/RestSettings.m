//
//  RestSettings.m
//  tp
//
//  Created by Ryan Romanchuk on 12/13/12.
//
//

#import "RestSettings.h"
#import "RestClient.h"
#import "AFJSONRequestOperation.h"

static NSString *RESOURCE = @"system/environment";

@implementation RestSettings

+ (NSDictionary *)mapping {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"environment", @"environment",
            nil];
    
}

+ (void)loadSettings:(void (^)(RestSettings *restSettings))onLoad onError:(void (^)(NSError *error))onError
{
    RestClient *restClient = [RestClient sharedClient];
    NSString *path = [RESOURCE stringByAppendingString:@".json"];
    NSMutableURLRequest *request = [restClient requestWithMethod:@"GET" path:path parameters:[RestClient defaultParameters]];
    
    DLog(@"CREATE REQUEST: %@", request);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
                                                                                            DLog(@"JSON: %@", JSON);
                                                                                            RestSettings *user = [RestSettings objectFromJSONObject:JSON mapping:[RestSettings mapping]];
                                                                                            if (onLoad)
                                                                                                onLoad(user);
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            [[UIApplication sharedApplication] hideNetworkActivityIndicator];
                                                                                            if (onError)
                                                                                                onError(error);
                                                                                        }];
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [operation start];

}

@end
