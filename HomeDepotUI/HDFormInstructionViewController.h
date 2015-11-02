//
//  HDFromFillViewController.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/18/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserImages.h"
@interface HDFromFillViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController *selfieImagepicker;
    UIImagePickerController *licenseFrontImagepicker;
    UIImagePickerController *licenseBackImagepicker;
}
@property (nonatomic, strong) UserImages *userImages;

@end
