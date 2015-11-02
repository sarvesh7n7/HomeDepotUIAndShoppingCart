//
//  UserDetails.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/21/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserImages.h"
@interface UserDetails : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *firstNane;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *DOB;
@property (nonatomic, strong) NSString *issueDate;
@property (nonatomic, strong) NSString *expiryDate;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *licenseClass;
@property (nonatomic, strong) NSString *streetNumber;
@property (nonatomic, strong) NSString *streetName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *annualIncome;
@property (nonatomic, strong) NSString *ssnNumber;
@property (nonatomic, strong) NSString *rentOrOwn;
@property (nonatomic, strong) NSString *monthlyRent;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *emailID;

@property (nonatomic, strong) UserImages *userImages;

+(UserDetails*)getInstance;
@end
