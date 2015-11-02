//
//  NetworkRequests.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/23/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "NetworkRequests.h"
#import "AFNetworking.h"
@implementation NetworkRequests


+ (void)findCorrespondingAddressForStreet:(NSString*)street city: (NSString*)city state: (NSString*) state withCompletion: (void (^)(NSString* zipcode, NSString* city, NSString* state)) completionBlock {
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [geoCoder geocodeAddressDictionary:@{
                                         (NSString*)kABPersonAddressStreetKey : street,
                                         (NSString*)kABPersonAddressCityKey: city,
                                         (NSString*)kABPersonAddressStateKey: state,
                                         (NSString*)kABPersonAddressCountryCodeKey : @"US"
                                         
                                         }
                     completionHandler:^(NSArray *placemarks, NSError *error) {
                         if ([placemarks count] > 0) {
                             CLPlacemark* placemark = [placemarks objectAtIndex:0];
                             
                              NSString* city = placemark.addressDictionary[(NSString*)kABPersonAddressCityKey];
                              NSString* state = placemark.addressDictionary[(NSString*)kABPersonAddressStateKey];
                             NSString* zipcode = placemark.addressDictionary[(NSString*)kABPersonAddressZIPKey];
                              NSString* street = placemark.addressDictionary[(NSString*)kABPersonAddressStreetKey];
    
                             NSLog(@"%@",city);
                             NSLog(@"%@",state);
                             NSLog(@"%@",zipcode);
                             NSLog(@"%@",street);
                             NSLog(@"City");
                             completionBlock(zipcode,city,state);
                             
                             
                         }
                         else {
                             
                         }
                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                     }];
}


+ (void) getTaxForZipCode: (NSString*) zipcode withCompletion: (void (^)(NSString* taxRate)) completionBlock{
    // 1
    
    NSString *string = [NSString stringWithFormat:@"https://api.taxjar.com/locations/%@/",zipcode];
    
    NSURL *url = [NSURL URLWithString:string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"Token token=\"dae79dc5154ccabd7cb169f616d605e7\"" forHTTPHeaderField:@"Authorization"];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *mydict = (NSDictionary *)responseObject;
        //NSLog(@"%@",mydict);
        NSDictionary *taxDetailDict = [mydict objectForKey:@"location"];
        NSString* tax = [taxDetailDict objectForKey:@"combined_rate"];

        completionBlock(tax);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Tax"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
        [alertView show];
        completionBlock(nil);
    }];
    
    // 5
    [operation start];
    
}
@end
