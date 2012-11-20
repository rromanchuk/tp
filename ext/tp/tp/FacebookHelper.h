//
//  FacebookHelper.h
//  tp
//
//  Created by Ryan Romanchuk on 11/20/12.
//
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "User+Manage.h"
@protocol FacebookHelperDelegate;

@interface FacebookHelper : NSObject
@property (strong, nonatomic) Facebook *facebook;
@property (strong, nonatomic) User *currentUser;
@property (weak, nonatomic) id <FacebookHelperDelegate> delegate;

+ (FacebookHelper *)shared;
- (IBAction)login:(id)sender;
@end

@protocol FacebookHelperDelegate <NSObject>

@required
- (void)userDidLogin;

@end