//
//  ShoppingCart.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/18/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetails.h"

typedef enum {
    none,
    abc,
    pqr,
    xyz
} couponType;

@interface ShoppingCart : NSObject

@property (nonatomic, strong) NSMutableDictionary *productQuantity;
@property (nonatomic, strong) NSMutableDictionary *productInfo;
@property (nonatomic) double merchandiseTotal;
@property (nonatomic) double discountedTotal;
@property (nonatomic) int totalQuantity;
@property (nonatomic) couponType appliedCuponType;


+(ShoppingCart*)getInstance;
-(void) addNewProductWithDetails: (ProductDetails *) newProductDetails;
-(void) displayAllProducts;
-(void) removeProductWithName: (NSString *) productName;
-(void) decByOneProductNamed: (NSString *) productName;
-(void) incByOneProductNamed: (NSString *) productName;
-(void) setQuantityOfProductNamed: (NSString *) productName toValue: (int) value;
-(void) calculateMerchadiseTotal;
-(void) calculateDiscountedTotalForCupon: (NSString*) cupon;
-(NSString *) getCouponValue;
@end
