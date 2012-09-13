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
@synthesize typeLabel;
@synthesize qtyLabel;
@synthesize totalLabel;
@synthesize typeValueLabel;
@synthesize qtyValueLabel;
@synthesize totalValueLabel;
@synthesize tellWorldLabel;

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
    self.typeLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:10.0];
    self.qtyLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:10.0];
    self.totalLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:10.0];
    self.typeValueLabel.font = [UIFont fontWithName:@"ArvilSans" size:25.0];
    self.qtyValueLabel.font = [UIFont fontWithName:@"ArvilSans" size:25.0];
    self.typeValueLabel.font = [UIFont fontWithName:@"ArvilSans" size:25.0];
    self.tellWorldLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:10.0];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBooYaLabel:nil];
    [self setHeadingLabel:nil];
    [self setOkButton:nil];
    [self setTypeLabel:nil];
    [self setQtyLabel:nil];
    [self setTotalLabel:nil];
    [self setTypeValueLabel:nil];
    [self setQtyValueLabel:nil];
    [self setTotalValueLabel:nil];
    [self setTellWorldLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue identifier] == @"DismissReceipt") {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
