//
//  OrderButton.m
//  tp
//
//  Created by Ryan Romanchuk on 6/24/12.
//  Copyright (c) 2012 Blippy. All rights reserved.
//

#import "OrderButton.h"

@implementation OrderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSLog(@"titlerectforcnotectrect");
    return contentRect;
}

@end
