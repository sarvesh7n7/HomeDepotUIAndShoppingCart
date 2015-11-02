//
//  ValidationUtilty.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/26/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ValidationUtilty : NSObject

+(BOOL)validateEmailWithString:(NSString*)email;
+(BOOL)validatePhoneNumber:(NSString *)phoneno;
+(BOOL)validNumber:(NSString *)number;
+(BOOL)validateUserName:(NSString *)nameString;
+(BOOL)validateSSN:(NSString *)SSNNumber;
+(BOOL)validateZipCode:(NSString *)PINNumber;
+(BOOL)validateDate:(NSString *) dateFromTextField;
+(BOOL)isexpiryDate:(NSString *) expiryDateString laterThanIssue:(NSString *) issueDateString;
+(BOOL)validateGender:(NSString *)gender;
+(BOOL)validateRentOrOwn:(NSString *)toValidate;
+(BOOL) isAnyFieldBlankIn: (NSArray *) UITextFieldsArray;
+(NSMutableArray*) getBlankFieldsLocation: (NSArray*) UITextFieldsArray;
+(BOOL) isAnyFieldIncorrect: (NSMutableArray *) incorrectFieldsLocation;
+(BOOL)validateID:(NSString *)number;
+(NSMutableArray*) getIncorrectFieldsLocation: (NSArray*) UITextFieldsArray;
@end
