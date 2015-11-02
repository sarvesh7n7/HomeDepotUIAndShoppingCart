//
//  NetworkRequests.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/23/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface NetworkRequests : NSObject


+ (void) getTaxForZipCode: (NSString*) zipcode withCompletion: (void (^)(NSString* taxRate)) completionBlock;

//+ (void)findCorrespondingAddressForStreet:(NSString*)street city: (NSString*)city state: (NSString*) state withCompletion: (void (^)(NSString* zipcode)) completionBlock;
+ (void)findCorrespondingAddressForStreet:(NSString*)street city: (NSString*)city state: (NSString*) state withCompletion: (void (^)(NSString* zipcode, NSString* city, NSString* state)) completionBlock;
@end
