//
//  FormView.m
//  tp
//
//  Created by Ryan Romanchuk on 11/10/12.
//
//

#import "FormView.h"

@implementation FormView

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
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"form-bg.png"]];
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
