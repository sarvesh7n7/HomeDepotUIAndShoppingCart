//
//  UserDetails.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/21/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "UserDetails.h"

@implementation UserDetails


static UserDetails *userDetails;

+(UserDetails*)getInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        userDetails = [[UserDetails alloc] init];
    });
    return userDetails;
}



@end
