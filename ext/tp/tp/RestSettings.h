//
//  RestSettings.h
//  tp
//
//  Created by Ryan Romanchuk on 12/13/12.
//
//

#import "RestObject.h"

@interface RestSettings : RestObject
@property (strong, nonatomic) NSString *environment;

+ (void)loadSettings:(void (^)(RestSettings *restSettings))onLoad onError:(void (^)(NSError *error))onError;

@end
