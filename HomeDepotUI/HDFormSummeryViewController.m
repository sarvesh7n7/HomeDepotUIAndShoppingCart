//
//  HDFormSummeryViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/20/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "HDFormSummeryViewController.h"
#import "HDCongratsViewController.h"

@interface HDFormSummeryViewController ()
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *testFieldArray;
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *imageLogoArray;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UIImageView *licenseFrontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *licenseBackImageView;

@end

@implementation HDFormSummeryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selfieImageView.layer.cornerRadius = self.selfieImageView.frame.size.height /2.0;
    self.selfieImageView.layer.masksToBounds = YES;
    self.selfieImageView.layer.borderWidth = 0;
    
    for( UILabel *currentTextField in self.testFieldArray){
        [currentTextField.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [currentTextField.layer setBorderWidth: 1.0];
    }
    for( UIImageView *currentImage in self.imageLogoArray){
        [currentImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [currentImage.layer setBorderWidth: 1.0];
    }

    //code to load the data into the labels.
    [[self.testFieldArray objectAtIndex:0] setText:self.userDetails.userID];
    [[self.testFieldArray objectAtIndex:1] setText:self.userDetails.firstNane];
    [[self.testFieldArray objectAtIndex:2] setText:self.userDetails.lastName];
    [[self.testFieldArray objectAtIndex:3] setText:self.userDetails.DOB];
    [[self.testFieldArray objectAtIndex:4] setText:self.userDetails.issueDate];
    [[self.testFieldArray objectAtIndex:5] setText:self.userDetails.expiryDate];
    [[self.testFieldArray objectAtIndex:6] setText:self.userDetails.gender];
    [[self.testFieldArray objectAtIndex:7] setText:self.userDetails.licenseClass];
    [[self.testFieldArray objectAtIndex:8] setText:self.userDetails.streetNumber];
    [[self.testFieldArray objectAtIndex:9] setText:self.userDetails.streetName];
    [[self.testFieldArray objectAtIndex:10] setText:self.userDetails.city];
    [[self.testFieldArray objectAtIndex:11] setText:self.userDetails.state];
    [[self.testFieldArray objectAtIndex:12] setText:self.userDetails.zipCode];
    [[self.testFieldArray objectAtIndex:13] setText:self.userDetails.annualIncome];
    [[self.testFieldArray objectAtIndex:14] setText:self.userDetails.ssnNumber];
    [[self.testFieldArray objectAtIndex:15] setText:self.userDetails.rentOrOwn];
    [[self.testFieldArray objectAtIndex:16] setText:self.userDetails.monthlyRent];
    [[self.testFieldArray objectAtIndex:17] setText:self.userDetails.phoneNumber];
    [[self.testFieldArray objectAtIndex:18] setText:self.userDetails.emailID];
    
    //code to load images in the imageViews
    [self.selfieImageView setImage: self.userDetails.userImages.selfieImage];
    [self.licenseFrontImageView setImage: self.userDetails.userImages.licenseFrontImage];
    [self.licenseBackImageView setImage: self.userDetails.userImages.licenseBackImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    HDCongratsViewController *dvc = [segue destinationViewController];
    dvc.userName = [NSString stringWithFormat:@" %@ %@",self.userDetails.firstNane,self.userDetails.lastName];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    NSDate *toSendDate = [dateFormatter dateFromString:self.userDetails.expiryDate];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *toSendDateString = [dateFormatter stringFromDate:toSendDate];
    dvc.expiryDate = toSendDateString ;
}


@end
