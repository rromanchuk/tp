//
//  PastOrdersViewController.m
//  tp
//
//  Created by Ryan Romanchuk on 11/29/12.
//
//

#import "PastOrdersViewController.h"
#import "OrderCell.h"
@interface PastOrdersViewController ()

@end

@implementation PastOrdersViewController

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
    ALog(@"current user is %@, and maoc %@", self.currentUser, self.managedObjectContext);
    [self setupFetchedResultsController];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowReceipt"]){
        NSLog(@"In prepare for segue");
        ShowReceiptViewController *vc = (ShowReceiptViewController *)segue.destinationViewController;
        vc.delegate = self;
        Order *order = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        vc.order = order;
    }
}



- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Order"];
    //request.predicate = [NSPredicate predicateWithFormat:@"showInFeed = %i", YES];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell = *cell = [tableView ]
    static NSString *CellIdentifier = @"OrderCell";
    Order *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ALog(@"order is %@ and date %@", order, order.createdAt);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    cell.dateLabel.text = [dateFormatter stringFromDate:order.createdAt];
    cell.totalAmountLabel.text = [NSString stringWithFormat:@"$%d", [order.totalAmountCents integerValue] / 100];
    
    if ([order.sku isEqualToString:@"REGULAR"]) {
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@ %d", @"Regular Roll x", [order.quantity integerValue]];
    } else {
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@ %d", @"Premium Roll x", [order.quantity integerValue]];
    }
    return cell;
}

#pragma mark - ReceiptDelegate methods
- (void)didDismissReceipt {
    [self dismissModalViewControllerAnimated:YES];
}

@end
