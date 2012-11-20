//
//  FacebookHelper.m
//  tp
//
//  Created by Ryan Romanchuk on 11/20/12.
//
//

#import "FacebookHelper.h"
#import "RestUser.h"

@implementation FacebookHelper
+ (FacebookHelper *)shared
{
    static dispatch_once_t pred;
    static FacebookHelper *shared;
    
    dispatch_once(&pred, ^{
        shared = [[FacebookHelper alloc] init];
    });
    
    return shared;
}

- (IBAction)login:(id)sender {
    
    
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:@"email", @"user_location", nil] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        [self sessionStateChanged:session state:status error:error];
    }];
    
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            
            FBRequest *me = [FBRequest requestForMe];
            [me startWithCompletionHandler: ^(FBRequestConnection *connection,
                                              NSDictionary<FBGraphUser> *my,
                                              NSError *error) {
                DLog(@"got data from facebook %@", my);
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:my.id, @"uid", session.accessToken, @"facebook_access_token", nil];
                [RestUser create:params onLoad:^(RestUser *restUser) {
                    DLog(@"rest user %@", restUser);
                    [RestUser setAuthToken:restUser.authenticationToken];
                    [self.currentUser setManagedObjectWithIntermediateObject:restUser];
                    [self.delegate userDidLogin];
                } onError:^(NSString *error) {
                    DLog(@"error: %@", error);
                }];
                
            }];

            ALog(@"session is open");
            if (self.facebook == nil) {
                self.facebook = [[Facebook alloc] initWithAppId:FBSession.activeSession.appID andDelegate:nil];
            }
            // Store the Facebook session information
            self.facebook.accessToken = FBSession.activeSession.accessToken;
            self.facebook.expirationDate = FBSession.activeSession.expirationDate;
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }    
}

@end
