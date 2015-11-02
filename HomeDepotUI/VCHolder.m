//
//  VCHolder.m
//  AutoLayoutIssueResolver
//
//  Created by Sarvesh Joshi on 1/2/15.
//  Copyright (c) 2015 RapidValueSolutions. All rights reserved.
//

#import "VCHolder.h"

@interface VCHolder ()



@end
@implementation VCHolder

static VCHolder *vcHolder;

+(VCHolder*)getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        vcHolder = [[VCHolder alloc] init];
        vcHolder.VCArray = [[NSMutableArray alloc] init];
    });
    return vcHolder;
}


@end
