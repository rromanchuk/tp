
#import "ShowReceiptViewController.h"
#import "User.h"
#import "FormView.h"
#import "FacebookHelper.h"
typedef enum {
    RollQuantityType6 = 6,
    RollQuantityType12 = 12,
    RollQuantityType24 = 24
    } RollQuantityType;

typedef enum {
    RollQualityTypeRegular,
    RollQualityTypePremium
} RollQualityType;

@protocol ReceiptDelegate;
@interface OrderController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, ReceiptDelegate, FacebookHelperDelegate> {
    NSString *option1; 
    NSString *option2; 
    NSString *option3;
    NSString *option4;
}

@property (weak) IBOutlet UINavigationBar *navigationBar;
@property (weak) IBOutlet UIBarButtonItem *rightBarButton;
@property (weak) IBOutlet UIButton *regularButton; 
@property (weak) IBOutlet UIButton *premiumButton;
@property (weak) IBOutlet UIButton *orderButton;
@property (weak) IBOutlet UIButton *orderCheckoutButton;

@property (weak) IBOutlet UIButton *qtyButton;
@property (weak) IBOutlet UIButton *qtyButtonSmall;

//scroll view
@property (weak) IBOutlet UIScrollView *scrollView;
//Table properties
@property (weak) IBOutlet UITableView *qtyTable;

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

@property (weak) IBOutlet UILabel *helperText;

//Checkout
@property (weak) IBOutlet UILabel *thatsItLabel;
@property (weak) IBOutlet UILabel *deliveryEst;
@property (weak) IBOutlet UIButton *cancelOrder;
@property (weak, nonatomic) IBOutlet FormView *formView;
@property (weak, nonatomic) IBOutlet UIImageView *deliveryTruckImage;

@property BOOL isOnCheckout;
@property (weak) UITextField *activeField;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) User *currentUser;
- (IBAction)didTapRegular:(id)sender;
- (IBAction)didTapPremium:(id)sender;

- (IBAction)qtyChange:(id)sender;
- (IBAction)scrollToCheckout:(id)sender;
- (IBAction)scrollToTop:(id)sender;
- (IBAction)removeKeyboard;
- (IBAction)sendOrder:(id)sender;
- (void)didDismissReceipt;
@end

