//
//  UIBarButtonItem+Borderless.h
//  tp
//
//  Created by Ryan Romanchuk on 5/10/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Borderless)
    + (UIBarButtonItem*)barItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;
@end
