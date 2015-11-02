//
//  ShoppingCart.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/18/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "ShoppingCart.h"


@implementation ShoppingCart{
  //  couponType appliedCuponType;
   
}

static ShoppingCart *shoppingCard;


+(ShoppingCart*)getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shoppingCard = [[ShoppingCart alloc] init];
    });
    return shoppingCard;
}
 
 

-(void) addNewProductWithDetails: (ProductDetails *) newProductDetails{
    NSNumber *quantity;
    //is dictionary having some data?
    if(!self.productInfo){
        quantity = [NSNumber numberWithInt:1];
        self.productQuantity = [NSMutableDictionary dictionaryWithObject:quantity forKey:newProductDetails.name];
        self.productInfo = [NSMutableDictionary dictionaryWithObject:newProductDetails forKey:newProductDetails.name];
        self.totalQuantity =1;
    }
    
    //if the dictionary is already created
    else{
        //if the item is already in the cart
        quantity = [self.productQuantity objectForKey:newProductDetails.name];
        if(quantity)
        {
            quantity = [NSNumber numberWithInt:[quantity intValue] + 1];
            [self.productQuantity setValue:quantity forKey:newProductDetails.name];
        }
        
        //if the item is in the cart
        else
        {
            quantity = [NSNumber numberWithInt:1];
            [self.productQuantity setValue:quantity forKey:newProductDetails.name];
            [self.productInfo setValue:newProductDetails forKey:newProductDetails.name];
        }
        self.totalQuantity++;
    }
}


-(void) setQuantityOfProductNamed: (NSString *) productName toValue: (int) value{
    //NSNumber *quantity = [self.productQuantity objectForKey:productName];
    NSNumber* quantity = [NSNumber numberWithInt:value];
    NSNumber *productQuantity = [self.productQuantity objectForKey:productName];
    int currentQuantity = [productQuantity intValue];
    [self.productQuantity setValue:quantity forKey:productName];
    [self calculateMerchadiseTotal];
    self.totalQuantity = self.totalQuantity+value-currentQuantity;
}

-(void) incByOneProductNamed: (NSString *) productName{
    //will let the minimum quantity to be 1. so we dont have to take care about
    NSNumber *quantity = [self.productQuantity objectForKey:productName];
    quantity = [NSNumber numberWithInt:[quantity intValue] + 1];
    [self.productQuantity setValue:quantity forKey:productName];
    [self calculateMerchadiseTotal];
    self.totalQuantity++;
}

-(void) decByOneProductNamed: (NSString *) productName{
   /* 
    NSNumber *quantity = [self.productQuantity objectForKey:productName];
    if([quantity intValue] == 1)
        [self removeProductWithName:productName];
    else
    {
        quantity = [NSNumber numberWithInt:[quantity intValue] + 1];
        [self.productQuantity setValue:quantity forKey:productName];
    }
    */
    
    NSNumber *quantity = [self.productQuantity objectForKey:productName];
    quantity = [NSNumber numberWithInt:[quantity intValue] - 1];
    [self.productQuantity setValue:quantity forKey:productName];
    [self calculateMerchadiseTotal];
    self.totalQuantity--;
}

-(void) removeProductWithName: (NSString *) productName{
    //should we take care of null dictionary
    [self.productInfo removeObjectForKey:productName];
    NSNumber *productQuantity = [self.productQuantity objectForKey:productName];
    int currentQuantity = [productQuantity intValue];
    self.totalQuantity = self.totalQuantity - currentQuantity;
    [self.productQuantity removeObjectForKey:productName];
    [self calculateMerchadiseTotal];
}
-(void) displayAllProducts{
    NSLog(@"%@",self.productInfo);
    NSLog(@"%@",self.productQuantity);
}


-(void) calculateMerchadiseTotal{
    double merchandiseTotal = 0;
    NSArray *productNames = [self.productQuantity allKeys];
    for(NSString *currentName in productNames )
    {
        NSNumber *quantity = [self.productQuantity objectForKey:currentName];
        
        NSString *productCostString = [[self.productInfo objectForKey:currentName] discountedPrice];
        productCostString = [productCostString stringByReplacingOccurrencesOfString:@"$" withString:@""];
        float productCost = [productCostString floatValue];
        merchandiseTotal = productCost *[quantity intValue] + merchandiseTotal;
        
    }
    self.merchandiseTotal = merchandiseTotal;
    [self calculateDiscountedTotal];
}

-(void) calculateDiscountedTotal{
    switch (self.appliedCuponType) {
        case none:
            self.discountedTotal = self.merchandiseTotal;
            break;
        case abc:
             self.discountedTotal = self.merchandiseTotal - 5;
            break;
        case xyz:
            self.discountedTotal = self.merchandiseTotal - 10;
        case pqr:
            self.discountedTotal = self.merchandiseTotal - 45;
            break;
        default:
            break;
    }
}

-(void) calculateDiscountedTotalForCupon: (NSString*) cupon{
    if([cupon isEqualToString:@"abc"]){
        self.discountedTotal = self.merchandiseTotal - 5;
        self.appliedCuponType = abc;
    }
    else if([cupon isEqualToString:@"xyz"]){
        self.discountedTotal = self.merchandiseTotal - 10;
        self.appliedCuponType = xyz;
    }
    else if([cupon isEqualToString:@"123"]){
        self.discountedTotal = self.merchandiseTotal - 45;
       self. appliedCuponType = pqr;
    }
    else{
        self.discountedTotal = self.merchandiseTotal;
       self. appliedCuponType = none;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error: Invaid Coupon" message:@"The Coupon you entered is Invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(NSString *)getCouponValue{
    switch (self.appliedCuponType) {
        case abc:
            return @"-$5.00";
            break;
        case pqr:
            return @"-$10.00";
            break;
        case xyz:
            return @"-$45.00";
            break;
        default:
            return @"-$0.00";
            break;
    }
}
//now we need to write code for :
//1. adjust merchadise total according to addition and removal of the productes
//2. adjust the discounted total accordingly. this will be easy as it can be reclaculated.
//3. keep a track if any coupen is applied or not. or else show the same total may be.
//4. fuck this shit!



@end
