//
//  WoodView.m
//  tp
//
//  Created by Ryan Romanchuk on 11/10/12.
//
//

#import "WoodView.h"

@implementation WoodView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood-bg.png"]];
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

@end
