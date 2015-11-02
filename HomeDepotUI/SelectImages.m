//
//  SelectImages.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/11/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "SelectImages.h"
typedef enum {
    none,
    selfie,
    licenseFront,
    licenseBack
} ImageViewType;


@implementation SelectImages{
    ImageViewType tappedImageView;
    short loadImageCount;
    UIImagePickerController *selfieImagepicker;
    UIImagePickerController *licenseFrontImagepicker;
    UIImagePickerController *licenseBackImagepicker;
    
}

-(IBAction)selectSelfiePicture:(id)sender {
    tappedImageView = selfie;
    selfieImagepicker= [[UIImagePickerController alloc] init];
    selfieImagepicker.delegate = self;
    [selfieImagepicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.ApplyFormMainViewController presentViewController:selfieImagepicker animated:YES completion:NULL];
    
}

-(IBAction)selectLicenseFrontPicture:(id)sender {
    tappedImageView = licenseFront;
    licenseFrontImagepicker= [[UIImagePickerController alloc] init];
    licenseFrontImagepicker.delegate = self;
    [licenseFrontImagepicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.ApplyFormMainViewController presentViewController:licenseFrontImagepicker animated:YES completion:NULL];
    
}

-(IBAction)selectLicenseBackPicture:(id)sender {
    tappedImageView = licenseBack;
    licenseBackImagepicker= [[UIImagePickerController alloc] init];
    licenseBackImagepicker.delegate = self;
    [licenseBackImagepicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.ApplyFormMainViewController presentViewController:licenseBackImagepicker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.userImages = [UserImages getInstance];
    if (tappedImageView == selfie) {
        self.userImages.selfieImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.selfieImageView setImage:self.userImages.selfieImage];
        tappedImageView = none;
    }
    
    else if (tappedImageView == licenseFront) {
        self.userImages.licenseFrontImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.licenseFrontImageView setImage:self.userImages.licenseFrontImage];
        tappedImageView = none;
    }
    
    else if (tappedImageView == licenseBack) {
        self.userImages.licenseBackImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.licenseBackImageView setImage:self.userImages.licenseBackImage];
        tappedImageView = none;
    }
    
    [self.ApplyFormMainViewController dismissViewControllerAnimated:YES completion:NULL];
    loadImageCount++;
    if(loadImageCount>=3){
        self.applyButton.enabled = YES;
        self.applyButton.alpha = 1.0;
    }
    
}
@end
