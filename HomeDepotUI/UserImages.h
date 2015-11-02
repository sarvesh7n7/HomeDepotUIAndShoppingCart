//
//  UserImages.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/2/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UserImages : NSObject
@property (nonatomic, strong) UIImage *selfieImage;
@property (nonatomic, strong) UIImage *licenseFrontImage;
@property (nonatomic, strong) UIImage *licenseBackImage;

+(UserImages*)getInstance;
@end
