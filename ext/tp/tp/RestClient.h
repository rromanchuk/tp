//
//  RestClient.h
//  tp
//
//  Created by Ryan Romanchuk on 11/5/12.
//
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"

@interface RestClient : AFHTTPClient
+ (RestClient *)sharedClient;

@end
