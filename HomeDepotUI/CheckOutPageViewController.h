//
//  CheckOutPageViewController.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/19/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCart.h"
#import "ProductDetailTableViewCell.h"
#import "PromoCodeTableViewCell.h"

@interface CheckOutPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, ProductDetailTableViewCellDelegate,PromoCodeTableViewCellDelegate>

@property (nonatomic, strong) ShoppingCart *shoppingCart;

@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;
@property (weak, nonatomic) IBOutlet UIImageView *buttonTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonFourImageView;


@end
