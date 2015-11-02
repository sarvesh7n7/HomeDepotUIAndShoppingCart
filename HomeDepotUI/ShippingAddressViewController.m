//
//  ShippingAddressViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/29/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "CustomerDetails.h"
#import "AddressPreviewViewController.h"
#import "CheckOutPageViewController.h"
#import "VCHolder.h"

@interface ShippingAddressViewController ()
@property (strong,nonatomic) CustomerDetails *customerDetails;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *addressLine1;
@property (weak, nonatomic) IBOutlet UITextField *addressLine2;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ShippingAddressViewController{
    VCHolder *myHolder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customerDetails = [CustomerDetails getInstance];
 
    //add the loaded View controller to the VCHolder Array
    myHolder = [VCHolder getInstance];
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [myHolder.VCArray addObject:self];
        [self enablePreviewVCButtons];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    //register of keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewWillAppear:(BOOL)animated{
    //register of keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) enablePreviewVCButtons{
    CheckOutPageViewController *CheckOutVC = [myHolder.VCArray objectAtIndex:0];
    CheckOutVC.buttonTwo.enabled = YES;
    CheckOutVC.buttonTwoImageView.alpha = 1.0f;
}

#pragma mark - button tapped methods

- (IBAction)nextClicked:(id)sender {
    [self fillCustomerDetails];
    if(myHolder.VCArray.count>=3) {
        [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:2] animated:YES];
    }
    else{
         [self performSegueWithIdentifier:@"toAddressPreview" sender:sender];
    }
}

- (IBAction)oneTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)twoTapped:(id)sender {
}

- (IBAction)threeTapped:(id)sender {
    [self fillCustomerDetails];
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:2] animated:YES];
}

- (IBAction)fourTapped:(id)sender {
    if([self isAddressChanged]){
        [self fillCustomerDetails];
        [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:2] animated:YES];
    }
    else{
        [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:2] animated:NO];
        [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:3] animated:YES];
    }
}


- (void) keyboardDidShow:(NSNotification *)notification{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) keyboardWillBeHidden:(NSNotification *)notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   // AddressPreviewViewController *apvc = [segue destinationViewController];
   // [self fillCustomerDetails];
       // apvc.customerDetails = self.customerDetails;
    
}

#pragma mark -textfield Delegates

-(BOOL) isAddressChanged{
    if(![self.customerDetails.addressLine1 isEqualToString:self.addressLine1.text])
        return YES;
    if(![self.customerDetails.addressLine2 isEqualToString:self.addressLine2.text])
        return YES;
    if(![self.customerDetails.city isEqualToString:self.city.text])
        return YES;
    if(![self.customerDetails.state isEqualToString:self.state.text])
        return YES;
    if(![self.customerDetails.zipCode isEqualToString:self.zipCode.text])
        return YES;
    return NO;
}

-(void) fillCustomerDetails{
    self.customerDetails.firstNane = self.firstName.text;
    self.customerDetails.lastName = self.lastName.text;
    self.customerDetails.addressLine1 = self.addressLine1.text;
    self.customerDetails.addressLine2 = self.addressLine2.text;
    self.customerDetails.city = self.city.text;
    self.customerDetails.state = self.state.text;
    self.customerDetails.zipCode = self.zipCode.text;
    self.customerDetails.phoneNumber = self.phoneNumber.text;
}
@end
