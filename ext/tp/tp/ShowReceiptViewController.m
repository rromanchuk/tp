//
//  ShowReceiptViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 8/23/12.
//
//

#import "ShowReceiptViewController.h"

@interface ShowReceiptViewController ()

@end

@implementation ShowReceiptViewController
@synthesize booYaLabel;
@synthesize headingLabel;
@synthesize okButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.booYaLabel.font = [UIFont fontWithName:@"ArvilSans" size:50.0];
    self.headingLabel.font = [UIFont fontWithName:@"ArvilSans" size:32.0];
    self.okButton.titleLabel.font = [UIFont fontWithName:@"ArvilSans" size:25.0];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBooYaLabel:nil];
    [self setHeadingLabel:nil];
    [self setOkButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
