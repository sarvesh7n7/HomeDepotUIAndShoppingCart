//
//  HDViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/18/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "HDViewController.h"

@interface HDViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *dayOrNightImage;
@property (weak, nonatomic) IBOutlet UIImageView *creditCardImageView;
@property (weak, nonatomic) IBOutlet UIButton *applyNowButton;
@property (weak, nonatomic) IBOutlet UIButton *notInterstedButton;
@property (weak, nonatomic) IBOutlet UILabel *saveLabel;
@property (weak, nonatomic) IBOutlet UILabel *saveDetailLabel;


@end

@implementation HDViewController

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
    
    [self selectDayOrNightImage];
    [self animateUiViews];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) animateUiViews{
    //animations.
    [UIView animateWithDuration:2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.creditCardImageView.frame = CGRectMake(18,400 ,330 ,215 );
                     }
                     completion:^(BOOL finished){
                     }];
    
    //animate the two buttons.
    [UIView animateWithDuration:2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.applyNowButton.frame = CGRectMake(24,-300 ,327 ,45 );
                     }
                     completion:^(BOOL finished){
                     }];
    [UIView animateWithDuration:2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.notInterstedButton.frame = CGRectMake(24,-300 ,327 ,45 );
                     }
                     completion:^(BOOL finished){
                     }];
    
    //animate the 1st ui label
    [UIView animateWithDuration:2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.saveLabel.frame = CGRectMake(300,299 ,102 ,26 );
                     }
                     completion:^(BOOL finished){
                     }];
    //animage the 2nd ui label.
    [UIView animateWithDuration:2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.saveDetailLabel.frame = CGRectMake(-300,340 ,280 ,38 );
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void) selectDayOrNightImage{
       NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    NSInteger currentHour = [components hour];
    
    if (((currentHour >= 18) && (currentHour <=24))|| ((currentHour >= 1) && (currentHour <= 6)))
        //NSLog(@"Night Time!!");
        self.dayOrNightImage.image=[UIImage imageNamed:@"nightimage.jpg"];
    
    
    else
        //NSLog(@"Day Time!!");
        self.dayOrNightImage.image=[UIImage imageNamed:@"dayimage.jpg"];
}

@end
