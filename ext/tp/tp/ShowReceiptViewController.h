//
//  ShowReceiptViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 8/23/12.
//
//

#import <UIKit/UIKit.h>

@interface ShowReceiptViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *booYaLabel;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *qtyValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tellWorldLabel;

@end
