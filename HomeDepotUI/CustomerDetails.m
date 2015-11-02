//
//  CustomerDetails.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/29/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "CustomerDetails.h"

@implementation CustomerDetails

static CustomerDetails *customerDetails;

+(CustomerDetails*)getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        customerDetails = [[CustomerDetails alloc] init];
    });
    return customerDetails;
}


@end
