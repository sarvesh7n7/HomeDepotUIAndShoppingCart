//
//  HDFormFillViewController.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/19/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails.h"
#import "ValidationUtilty.h"
@interface HDFormFillViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate>
@property (nonatomic, strong) UserDetails *userDetails;
@end
