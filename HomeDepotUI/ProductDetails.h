//
//  ProductDetails.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/17/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ProductDetails : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *actualPrice;
@property (strong, nonatomic) NSString *discountedPrice;
@property (strong, nonatomic) NSString *percentDiscount;
@property (strong, nonatomic) UIImage *image;

//+(ProductDetails*)getInstance;
@end
