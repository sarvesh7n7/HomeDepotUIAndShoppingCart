//
//  PriceDetailsTableViewCell.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/20/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchandiseTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@end
