//
//  CustomerDetails.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/29/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerDetails : NSObject

@property (nonatomic, strong) NSString *firstNane;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *addressLine1;
@property (nonatomic, strong) NSString *addressLine2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *phoneNumber;

+(CustomerDetails*)getInstance;

@end
