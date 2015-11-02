//
//  ProductDetailTableViewCell.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/19/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "ProductDetailTableViewCell.h"
#import "PriceDetailsTableViewCell.h"
#import "CheckOutPageViewController.h"


@implementation ProductDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.shoppingCart = [ShoppingCart getInstance];
    [self setBordersToQuantityView];
    self.quantityTextField.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)reduceQuantity:(id)sender {

    NSString *quantityStr = self.quantityTextField.text;
    int quantity = [quantityStr intValue];
    if(quantity>1) {
        quantity--;
        quantityStr = [NSString stringWithFormat:@"%d",quantity];
        //self.vQuantityLabel.text = quantityStr;
        self.quantityTextField.text = quantityStr;
        self.quantityLabel.text = quantityStr;
        [self.shoppingCart decByOneProductNamed:self.nameLabel.text];
        [self.delegate productDidDecrementByOne];
    }
}

- (IBAction)increaseQuantity:(id)sender {
    NSString *quantityStr = self.quantityTextField.text;
    int quantity = [quantityStr intValue];
    quantity++;
    quantityStr = [NSString stringWithFormat:@"%d",quantity];
    //self.vQuantityLabel.text = quantityStr;
    self.quantityTextField.text = quantityStr;
    self.quantityLabel.text = quantityStr;
    [self.shoppingCart incByOneProductNamed:self.nameLabel.text];
    [self.delegate productDidIncrementByOne];

}


- (IBAction)deleteProduct:(id)sender {
    [self.shoppingCart removeProductWithName:self.nameLabel.text];
    [self.delegate didDeletedProduct:self];
}

-(void) setBordersToQuantityView {
    UIColor *borderColor = [UIColor colorWithRed:210/225.0 green:212/225.0 blue:213/225.0 alpha:1.0];
    self.quantityView.layer.borderWidth = 1.0f;
    self.quantityView.layer.borderColor = borderColor.CGColor;
    self.quantityTextField.layer.borderWidth = 1.0f;
    self.quantityTextField.layer.borderColor = borderColor.CGColor;
   // self.quantityTextField.text = quantityStr;
}



#pragma mark - uitextfield delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)textFieldDidEndEditing:(UITextField *)sender {
    NSString *quantityStr = self.quantityTextField.text;
    int quantity = [quantityStr intValue];
    self.quantityLabel.text = quantityStr;
    [self.shoppingCart setQuantityOfProductNamed:self.nameLabel.text toValue:quantity];
    [self.shoppingCart displayAllProducts];
    [self.delegate productValueChangedto:quantity];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 0 && ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]])
        return NO;
    if (range.length == 0 && [string isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}
@end
