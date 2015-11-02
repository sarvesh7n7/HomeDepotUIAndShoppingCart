//
//  AddressPreviewViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/29/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "AddressPreviewViewController.h"
#import "ProductOrderViewController.h"
#import "ShippingAddressViewController.h"
#import "CheckOutPageViewController.h"
#import "NetworkRequests.h"
#import "VCHolder.h"

@interface AddressPreviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressPreviewLabel;

@end

@implementation AddressPreviewViewController{
     VCHolder *myHolder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add the loaded View controller to the VCHolder Array
    myHolder = [VCHolder getInstance];
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [myHolder.VCArray addObject:self];
        [self enablePreviewVCButtons];
    });
    //the logic to check the address here.
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.customerDetails = [CustomerDetails getInstance];
    [self validateAddress];
    NSString *addressString = [NSString stringWithFormat:@"%@ %@,\n %@ %@ -%@",self.customerDetails.addressLine1,self.customerDetails.addressLine2,self.customerDetails.city,self.customerDetails.state,self.customerDetails.zipCode];
    self.addressPreviewLabel.text = addressString;

}

-(void) enablePreviewVCButtons{
    ShippingAddressViewController *shippingVC = [myHolder.VCArray objectAtIndex:1];
    shippingVC.buttonThree.enabled = YES;
    shippingVC.buttonThreeImage.alpha = 1.0f;
    CheckOutPageViewController *CheckOutVC = [myHolder.VCArray objectAtIndex:0];
    CheckOutVC.buttonThree.enabled = YES;
    CheckOutVC.buttonThreeImageView.alpha = 1.0f;
}

#pragma mark - button tapped methods

- (IBAction)useEnteredAddress:(id)sender {
    if(myHolder.VCArray.count>=4){
        ProductOrderViewController *povc = [myHolder.VCArray objectAtIndex:3];
        povc.zipCode = self.customerDetails.zipCode;
        [self.navigationController pushViewController:povc animated:YES];
    }
    else{
        [self performSegueWithIdentifier:@"finalPreview" sender:sender];
    }

   
}
- (IBAction)changeAddress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)oneTapped:(id)sender {
    [self.navigationController popToViewController:[myHolder.VCArray objectAtIndex:0] animated:YES];
}

- (IBAction)twoTapped:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)threeTapped:(id)sender {
}

- (IBAction)fourTapped:(id)sender {
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:3] animated:YES];
    
}



-(void) validateAddress{
    NSString *streetLine = [NSString stringWithFormat:@"%@ %@",self.customerDetails.addressLine1,self.customerDetails.addressLine2];
    
    [NetworkRequests findCorrespondingAddressForStreet:streetLine city: self.customerDetails.city state:self.customerDetails.state withCompletion:^(NSString *returnedZip,NSString *returnedCity, NSString *returnedState) {
        returnedCity  = [returnedCity lowercaseString];
        NSString *userCityString = [self.customerDetails.city lowercaseString];
        if(([returnedZip isEqualToString:self.customerDetails.zipCode]) &&([returnedCity isEqualToString:userCityString])){
            NSString *note = [NSString stringWithFormat:@"We checked the address you entered with US.Postal Services and the address is correct. you can change the address or procceed with the adress as is. "];
            self.addressNoteLabel.text =note;
            
        }
       else{
            NSString *note = [NSString stringWithFormat:@"We checked the address you entered with US.Postal Services and found to be invalid. Please make sure your address is correct or procceed with the adress as is."];
            self.addressNoteLabel.text =note;
        }
    }];
    //[NetworkRequests getTaxForZipCode:self.customerDetails.zipCode withCompletion:
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ProductOrderViewController *povc = [segue destinationViewController];
    povc.zipCode = self.customerDetails.zipCode;
}


@end
