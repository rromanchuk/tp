//
//  ShowReceiptViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 8/23/12.
//
//

#import <UIKit/UIKit.h>
#import "Order+Manage.h"
@protocol ReceiptDelegate;

@interface ShowReceiptViewController : UIViewController

@property NSInteger selectedQualityType;
@property NSInteger selectedQuantity;
@property NSInteger amountInCents;

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
@property (weak) id<ReceiptDelegate> delegate;
@property (strong) Order *order;

- (IBAction)didDismissReceipt:(id)sender;

@end

@protocol ReceiptDelegate <NSObject>

@required
-(void)didDismissReceipt;

@end
