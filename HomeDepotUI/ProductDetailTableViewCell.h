//
//  ProductDetailTableViewCell.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/19/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShoppingCart.h"

@protocol ProductDetailTableViewCellDelegate;


@interface ProductDetailTableViewCell : UITableViewCell <UITextFieldDelegate>




@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;

@property (weak, nonatomic) IBOutlet UIView *quantityView;

@property (weak, nonatomic) IBOutlet UITableView *mytableview;

@property (nonatomic, strong) ShoppingCart *shoppingCart;

@property (nonatomic,strong) id<ProductDetailTableViewCellDelegate> delegate;

@end

@protocol ProductDetailTableViewCellDelegate <NSObject>

@optional

- (void) productDidDecrementByOne;
- (void) productDidIncrementByOne;
- (void) productValueChangedto: (NSInteger) value;
- (void) didDeletedProduct:(ProductDetailTableViewCell *) productCell;

@end

