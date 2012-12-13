//
//  OrderCell.h
//  tp
//
//  Created by Ryan Romanchuk on 12/11/12.
//
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
