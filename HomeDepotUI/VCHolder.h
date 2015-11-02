//
//  VCHolder.h
//  AutoLayoutIssueResolver
//
//  Created by Sarvesh Joshi on 1/2/15.
//  Copyright (c) 2015 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VCHolder : NSObject


@property (strong, nonatomic) NSMutableArray *VCArray;
+(VCHolder*)getInstance;
//-(void)addViewController: (UIViewController *) vc;
//-(NSInteger) getCount;

@end
