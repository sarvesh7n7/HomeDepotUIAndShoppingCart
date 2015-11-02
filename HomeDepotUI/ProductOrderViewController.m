//
//  ProductOrderViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/29/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//


#import "CheckOutPageViewController.h"
#import "ShippingAddressViewController.h"
#import "AddressPreviewViewController.h"
#import "ProductOrderViewController.h"
#import "NetworkRequests.h"
#import "ShoppingCart.h"
#import "VCHolder.h"


@interface ProductOrderViewController ()
@property (strong, nonatomic) ShoppingCart *myCart;

@property (nonatomic) double totalTax;
@property (nonatomic) double taxedTotal;
@property (nonatomic) double taxedShippedTotal;

@property (weak, nonatomic) IBOutlet UITextField *totalQuantity;
@property (weak, nonatomic) IBOutlet UITextField *merchandiseTotal;
@property (weak, nonatomic) IBOutlet UITextField *discount;
@property (weak, nonatomic) IBOutlet UITextField *shipping;
@property (weak, nonatomic) IBOutlet UITextField *taxAmount;
@property (weak, nonatomic) IBOutlet UITextField *finalTotal;

@property (weak, nonatomic) IBOutlet UIView *costDetailView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIView *standardShipView;
@property (weak, nonatomic) IBOutlet UIView *expressShipView;
@property (weak, nonatomic) IBOutlet UIView *nextDaySaverView;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderButton;

@end

@implementation ProductOrderViewController{
     VCHolder *myHolder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //change the border color of the cost detail view
    self.costDetailView.layer.borderWidth = 1.0f;
    self.costDetailView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //add the loaded View controller to the VCHolder Array
    myHolder = [VCHolder getInstance];
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [myHolder.VCArray addObject:self];
        [self enablePreviewVCButtons];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    
    self.myCart = [ShoppingCart getInstance];
    self.totalQuantity.text = [NSString stringWithFormat:@"%d",self.myCart.totalQuantity];
    self.merchandiseTotal.text = [NSString stringWithFormat:@"$%.2f",self.myCart.merchandiseTotal];
    self.discount.text = [NSString stringWithFormat:@"%@",[self.myCart getCouponValue]];
    self.shipping.text = [NSString stringWithFormat:@"$%.2f",kstandardShpping];
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    [NetworkRequests getTaxForZipCode: self.zipCode withCompletion:^(NSString* taxRate) {
        // NSString* tax = taxRate;
        if(!taxRate ){
            //disable the button;
            self.indicatorView.hidden = YES;
            self.taxAmount.text = [NSString stringWithFormat:@"$0.00"];
            
            self.taxedShippedTotal = self.taxedTotal ;
            self.finalTotal.text = [NSString stringWithFormat:@"$%.2f",self.taxedShippedTotal];
            self.placeOrderButton.enabled = NO;
            self.placeOrderButton.alpha = 0.5f;
        }
        else{
            
            self.placeOrderButton.enabled = YES;
            self.placeOrderButton.alpha = 1.0f;
            double taxPercent = [taxRate doubleValue];
            self.totalTax = self.myCart.merchandiseTotal*taxPercent;
            self.taxAmount.text = [NSString stringWithFormat:@"$%.2f",self.totalTax];
            self.taxedTotal = self.myCart.discountedTotal + self.totalTax;
            self.taxedShippedTotal = self.taxedTotal + kstandardShpping;
            self.finalTotal.text = [NSString stringWithFormat:@"$%.2f",self.taxedShippedTotal];
            self.indicatorView.hidden = YES;
        }
       
        
        // NSLog(@"%@",tax);
    }];

}

-(void) enablePreviewVCButtons{
    
    AddressPreviewViewController *addressVC = [myHolder.VCArray objectAtIndex:2];
    addressVC.buttonFour.enabled = YES;
    addressVC.buttonFourImage.alpha = 1.0f;
    
    ShippingAddressViewController *shippingVC = [myHolder.VCArray objectAtIndex:1];
    shippingVC.buttonFour.enabled = YES;
    shippingVC.buttonFourImage.alpha = 1.0f;
    
    CheckOutPageViewController *CheckOutVC = [myHolder.VCArray objectAtIndex:0];
    CheckOutVC.buttonFour.enabled = YES;
    CheckOutVC.buttonFourImageView.alpha = 1.0f;
    
    
}


#pragma mark - button tapped

- (IBAction)ApplyStandardShipping:(id)sender {
    self.taxedShippedTotal = self.taxedTotal + kstandardShpping;
    self.finalTotal.text = [NSString stringWithFormat:@"$%.2f",self.taxedShippedTotal];
    
}

- (IBAction)ApplyExpressShipping:(id)sender {
    self.taxedShippedTotal = self.taxedTotal + kexpressShipping;
    self.finalTotal.text = [NSString stringWithFormat:@"$%.2f",self.taxedShippedTotal];
    
}
- (IBAction)ApplyNextDayShipping:(id)sender {
    self.taxedShippedTotal = self.taxedTotal + knextDaySaver;
    self.finalTotal.text = [NSString stringWithFormat:@"$%.2f",self.taxedShippedTotal];
}

- (IBAction)oneTapped:(id)sender {
    [self.navigationController popToViewController:[myHolder.VCArray objectAtIndex:0] animated:YES];
}

- (IBAction)twoTapped:(id)sender {
    [self.navigationController popToViewController:[myHolder.VCArray objectAtIndex:1] animated:YES];
}

- (IBAction)threeTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)fourTapped:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
