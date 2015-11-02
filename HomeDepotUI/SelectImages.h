//
//  SelectImages.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/11/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserDetails.h"
@interface SelectImages : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}


@property (weak, nonatomic) IBOutlet UIViewController *ApplyFormMainViewController;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UIImageView *licenseFrontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *licenseBackImageView;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (nonatomic, strong) UserImages *userImages;
@end
