//
//  HDCongratsViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/20/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "HDCongratsViewController.h"

@interface HDCongratsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiryDateLabel;

@end

@implementation HDCongratsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameLabel.text = self.userName;
    self.expiryDateLabel.text = [NSString stringWithFormat:@" EXPIRES ON: %@",self.expiryDate];
    // Do any additional setup after loading the view.
      self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
