//
//  AppDelegate.h
//  tp
//
//  Created by Ryan Romanchuk on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate> {
    Facebook *facebook;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Facebook *facebook;

@end
