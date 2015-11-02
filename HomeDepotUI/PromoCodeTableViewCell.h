//
//  PromoCodeTableViewCell.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/22/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCart.h"

@protocol PromoCodeTableViewCellDelegate <NSObject>
@optional

- (void) didTappedApplyCoupon;

@end

@interface PromoCodeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subtotalLabel;
@property (weak, nonatomic) IBOutlet UITextField *promoCodeLabel;

@property (weak, nonatomic) ShoppingCart *shoppingCart;
@property (nonatomic,strong) id<PromoCodeTableViewCellDelegate> delegate;
@end
