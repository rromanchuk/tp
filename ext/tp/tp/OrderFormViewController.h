//
//  OrderFormViewController.h
//  tp
//
//  Created by Ryan Romanchuk on 12/5/12.
//
//

#import "FormView.h"
#import "User+Manage.h"
@protocol OrderFormDelegate;

@interface OrderFormViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property BOOL fromConfig;
@property (nonatomic, strong) User *currentUser;

@property (weak, nonatomic) IBOutlet FormView *formView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

//Form
@property (weak) IBOutlet UILabel *nameLabel;
@property (weak) IBOutlet UITextField *nameTextField;

@property (weak) IBOutlet UILabel *emailLabel;
@property (weak) IBOutlet UITextField *emailTextField;

@property (weak) IBOutlet UILabel *address1Label;
@property (weak) IBOutlet UITextField *address1TextField;

@property (weak) IBOutlet UILabel *address2Label;
@property (weak) IBOutlet UITextField *address2Textfield;

@property (weak) IBOutlet UILabel *cityLabel;
@property (weak) IBOutlet UITextField *cityTextField;

@property (weak) IBOutlet UILabel *stateLabel;
@property (weak) IBOutlet UITextField *stateTextField;

@property (weak) IBOutlet UILabel *zipLabel;
@property (weak) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UILabel *creditCardLabel;
@property (weak, nonatomic) IBOutlet UITextField *creditCardTextField;
@property (weak, nonatomic) IBOutlet UILabel *csvLabel;
@property (weak, nonatomic) IBOutlet UITextField *csvTextField;
@property (weak, nonatomic) IBOutlet UILabel *expirationLabel;
@property (weak, nonatomic) IBOutlet UITextField *expiryMonth;
@property (weak, nonatomic) IBOutlet UITextField *expiryYear;
@property (weak, nonatomic) IBOutlet UIButton *orderCheckoutButton;
@property (weak, nonatomic) IBOutlet UILabel *lastFourLabel;

@property (weak) IBOutlet UILabel *helperText;

//Checkout
@property (weak) IBOutlet UILabel *thatsItLabel;
@property (weak) IBOutlet UILabel *deliveryEst;
@property (weak) IBOutlet UIButton *cancelOrder;
@property (weak, nonatomic) IBOutlet UIImageView *deliveryTruckImage;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)didTapDone:(id)sender;

@property (weak) id <OrderFormDelegate> delegate;

@property BOOL isOnCheckout;
@property (weak) UITextField *activeField;
- (IBAction)didTapSegment:(id)sender;
- (IBAction)didTapCancel:(id)sender;
@end

@protocol OrderFormDelegate <NSObject>

- (void)didFinishFillingOutForm;
- (void)newCustomerInformation:(NSString *)ccNumber year:(NSString *)year month:(NSString *)month code:(NSString *)code;
- (void)didCancelOrderForm;

@end
