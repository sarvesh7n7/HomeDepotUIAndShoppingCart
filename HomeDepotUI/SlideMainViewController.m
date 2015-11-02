//
//  SlideMainViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/10/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "SlideMainViewController.h"

@interface SlideMainViewController ()

@end

@implementation SlideMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath{
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRow";
            break;
        case 1:
            identifier = @"secondRow";
            break;
    }
    return identifier;
}

//set the primary menu
- (AMPrimaryMenu)primaryMenu{
    return AMPrimaryMenuRight;
}

- (void)configureRightMenuButton:(UIButton *)button{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 13);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"simpleMenuButton"] forState:UIControlStateNormal];
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
