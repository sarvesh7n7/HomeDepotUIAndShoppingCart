//
//  UserImages.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/2/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "UserImages.h"

@implementation UserImages

static UserImages *userImages;

+(UserImages*)getInstance {
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        userImages = [[UserImages alloc] init];
    });
    return userImages;
}


@end


