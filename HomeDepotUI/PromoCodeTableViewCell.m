//
//  PromoCodeTableViewCell.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/22/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "PromoCodeTableViewCell.h"

@implementation PromoCodeTableViewCell


- (void)awakeFromNib {
    
    // Initialization code
    self.shoppingCart = [ShoppingCart getInstance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)applyCoupon:(id)sender {
    [self.shoppingCart calculateDiscountedTotalForCupon:self.promoCodeLabel.text];
    [self.delegate didTappedApplyCoupon];
}

@end
