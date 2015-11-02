//
//  HDFromFillViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/18/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "HDFormInstructionViewController.h"
#import "HDFormFillViewController.h"
#import "AMSlideMenuMainViewController.h"

typedef enum {
    none,
    selfie,
    licenseFront,
    licenseBack
} ImageViewType;

@interface HDFromFillViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *registerScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UIImageView *licenseFrontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *licenseBackImageView;
@property (weak, nonatomic) IBOutlet UILabel *stepOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepThreeLabel;
@property (weak, nonatomic) IBOutlet UIView *stepView;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;




@end

@implementation HDFromFillViewController{
    ImageViewType tappedImageView;
    short loadImageCount;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"SourceSansPro-Regular" size:22],
      NSFontAttributeName,
      [UIColor whiteColor],
      NSForegroundColorAttributeName,
      nil]];
    
    loadImageCount = 0;
    //self.userImages = [[UserImages alloc] init];
    self.userImages =[UserImages getInstance];
    [self setInterfaceElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
   // self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


#pragma mark - back button

- (IBAction)returnToRoot:(id)sender {
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    [mainVC.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - helper Methods

-(void) setInterfaceElements{
    //code for setting the round border of the selfie image
    self.selfieImageView.layer.cornerRadius = self.selfieImageView.frame.size.height /2.0;
    self.selfieImageView.layer.masksToBounds = YES;
    self.selfieImageView.layer.borderWidth = 0;
    
    //code for setting the border of the stepView
    self.stepView.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0].CGColor;
    self.stepView.layer.borderWidth = 1.0f;
    UIFont *stepsFont =  [UIFont fontWithName:@"SourceSansPro-Regular" size:15];
    //changing the font color of the selected font
    NSMutableAttributedString * stepOneString = [[NSMutableAttributedString alloc]initWithString:self.stepOneLabel.text];
    NSMutableAttributedString * stepTwoString = [[NSMutableAttributedString alloc]initWithString:self.stepTwoLabel.text];
    NSMutableAttributedString * stepThreeString = [[NSMutableAttributedString alloc]initWithString:self.stepThreeLabel.text];
    NSRange range=[self.stepOneLabel.text rangeOfString:@"Step 1:"];
    [stepOneString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    [stepOneString addAttribute:NSFontAttributeName value:stepsFont range:range];
    //[stepOneString addAttribute:NSFontAttributeName value:[UIFont fontWithName: @"SourceSansPro" size:15.0] range:range];
    [self.stepOneLabel setAttributedText:stepOneString];
    range=[self.stepTwoLabel.text rangeOfString:@"Step 2:"];
    [stepTwoString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    [stepTwoString addAttribute:NSFontAttributeName value:stepsFont range:range];
    [self.stepTwoLabel setAttributedText:stepTwoString];
    range=[self.stepThreeLabel.text rangeOfString:@"Step 3:"];
    [stepThreeString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    [stepThreeString addAttribute:NSFontAttributeName value:stepsFont range:range];
    [self.stepThreeLabel setAttributedText:stepThreeString];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    HDFormFillViewController *dvc = [segue destinationViewController];
    //dvc.userDetails = [[UserDetails alloc] init];
    dvc.userDetails = [UserDetails getInstance];
    dvc.userDetails.userImages =self.userImages;

}



@end
