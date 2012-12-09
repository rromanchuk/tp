
#import "ShowReceiptViewController.h"
#import "User.h"
#import "FormView.h"
#import "FacebookHelper.h"
#import "OrderFormViewController.h"

typedef enum {
    RollQuantityType6 = 6,
    RollQuantityType12 = 12,
    RollQuantityType24 = 24
    } RollQuantityType;

typedef enum {
    RollQualityTypeRegular,
    RollQualityTypePremium
} RollQualityType;

@interface OrderController : UIViewController <UITableViewDelegate, UITableViewDataSource, ReceiptDelegate, FacebookHelperDelegate, OrderFormDelegate> {
    NSString *option1; 
    NSString *option2; 
    NSString *option3;
    NSString *option4;
}

@property (weak) IBOutlet UIButton *regularButton; 
@property (weak) IBOutlet UIButton *premiumButton;
@property (weak) IBOutlet UIButton *orderButton;

@property (weak) IBOutlet UIButton *qtyButton;

//Table properties
@property (weak) IBOutlet UITableView *qtyTable;



@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) User *currentUser;
- (IBAction)didTapRegular:(id)sender;
- (IBAction)didTapPremium:(id)sender;

- (IBAction)qtyChange:(id)sender;
- (IBAction)scrollToCheckout:(id)sender;
- (IBAction)scrollToTop:(id)sender;
- (IBAction)sendOrder:(id)sender;
- (void)didDismissReceipt;
@end

