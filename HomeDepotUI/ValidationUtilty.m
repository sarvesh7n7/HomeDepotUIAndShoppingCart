//
//  ValidationUtilty.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/26/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "ValidationUtilty.h"
//#import "Constants.h"

@implementation ValidationUtilty

//validate email address
+ (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//validate phone number
+(BOOL)validatePhoneNumber:(NSString *)phoneno {
    NSString *phoneRegex = @"^(\\([0-9]{3})\\) [0-9]{3}-[0-9]{4}$";
    NSString *phoneRegex1 = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSString *phoneRegex2 = @"^[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex1];
    NSPredicate *phoneTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
    if( [phoneTest evaluateWithObject:phoneno])
        return YES;
    
    else if ([phoneTest1 evaluateWithObject:phoneno])
        return YES;
    
     else if ([phoneTest2 evaluateWithObject:phoneno])
         return YES;
    return NO;
    
}

+(BOOL)validateUserName:(NSString *)nameString {
    NSCharacterSet *alphaNums = [NSCharacterSet letterCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:nameString];
    return [alphaNums isSupersetOfSet:inStringSet];
}

+(BOOL)validateSSN:(NSString *)SSNNumber {
    NSString *phoneRegex1 = @"^[0-9]{3}-[0-9]{2}-[0-9]{4}$";
    NSString *phoneRegex2 = @"^[0-9]{9}$";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex1];
    NSPredicate *phoneTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
    if ([phoneTest1 evaluateWithObject:SSNNumber])
        return YES;
    else if ([phoneTest2 evaluateWithObject:SSNNumber])
        return YES;
    return NO;
}

+(BOOL)validateZipCode:(NSString *)PINNumber {
    NSString *phoneRegex = @"^[0-9]{5}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if ([phoneTest evaluateWithObject:PINNumber])
        return YES;
    return NO;
}

//validate fields to be just numbers
+(BOOL)validNumber:(NSString *)number {
    number = [number stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:number];
    return [alphaNums isSupersetOfSet:inStringSet];
}

+(BOOL)validateID:(NSString *)number{
    NSCharacterSet *alphaNums = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:number];
    return [alphaNums isSupersetOfSet:inStringSet];
}

+(BOOL)validateGender:(NSString *)gender{
    if([gender isEqualToString:@"Male"] || [gender isEqualToString:@"male"] ){
        return YES;
    }
    if([gender isEqualToString:@"Female"] || [gender isEqualToString:@"Female"] ){
        return YES;
    }
    return NO;
}

+(BOOL)validateRentOrOwn:(NSString *)toValidate{
    if([toValidate isEqualToString:@"Rent"] || [toValidate isEqualToString:@"rent"] ){
        return YES;
    }
    if([toValidate isEqualToString:@"Own"] || [toValidate isEqualToString:@"Own"] ){
        return YES;
    }
    return NO;
}

+(BOOL)validateDate:(NSString *) dateFromTextField {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMMM yyyy"];// here set format which you want...
    NSDate *date = [dateFormat dateFromString:dateFromTextField];
    NSString *dateString = [dateFormat stringFromDate:date];
   // NSLog(@"Date :%@",dateString);
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger dateYear = [components year];
    
    if(dateString) {
        NSString *yearRegex = @"^[0-9]{4}$";
        NSPredicate *yearTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", yearRegex];
        if ([yearTest evaluateWithObject:[NSString stringWithFormat:@"%ld",(long)dateYear]])
            return YES;
        else
            return NO;
    }
    return NO;
}

+(BOOL)isexpiryDate:(NSString *) expiryDateString laterThanIssue:(NSString *) issueDateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMMM yy"];// here set format which you want...
    NSDate *issueDate = [dateFormat dateFromString:issueDateString];
    NSDate *expiryDate = [dateFormat dateFromString:expiryDateString];
    if(expiryDate == [expiryDate laterDate:issueDate])
        return YES;
    return NO;
}

// to check if some fields are empty or not
+(BOOL) isAnyFieldBlankIn: (NSArray *) UITextFieldsArray{
    for( UITextField *currentTextField in UITextFieldsArray){
        if([[[currentTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] length] ==0 ){
            return YES;
        }
    }
    return NO;
}

//get the locations of the blank fields
+(NSMutableArray*) getBlankFieldsLocation: (NSArray*) UITextFieldsArray {
    NSMutableArray *isBlankField = [[NSMutableArray alloc] init];
    for( UILabel *currentTextField in UITextFieldsArray) {
        if([[[currentTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] length] ==0 )
            [isBlankField addObject:[NSNumber numberWithBool:YES]];
        else
            [isBlankField addObject:[NSNumber numberWithBool:NO]];
    }
    return isBlankField;
}

//check if any field is incorrect or not
+(BOOL) isAnyFieldIncorrect: (NSMutableArray *) incorrectFieldsLocation{
    for( NSNumber *currentField in incorrectFieldsLocation) {
        if([currentField boolValue] == YES){
            return YES;
        }
    }
    return NO;
}

//check for the incorrect fields
+(NSMutableArray*) getIncorrectFieldsLocation: (NSArray*) UITextFieldsArray{
    NSMutableArray *isIncorrectField = [[NSMutableArray alloc] init];
    
    //initialize the array to all no values
    for (int i=0; i<19; i++) {
        [isIncorrectField addObject:[NSNumber numberWithBool:NO]];
    }
    
    //change the enteries which are incorrect.
    
    //validation of Email
    if (![ValidationUtilty validateEmailWithString: [[UITextFieldsArray objectAtIndex:18] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:18];
    
    //validation of Phone Number
    if (![ValidationUtilty validatePhoneNumber:[[UITextFieldsArray objectAtIndex:17] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:17];
    
    //validation of Rent or Own
    if (![ValidationUtilty validateRentOrOwn:[[UITextFieldsArray objectAtIndex:15] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:15];
    
    //validation of ssn
    if (![ValidationUtilty validateSSN:[[UITextFieldsArray objectAtIndex:14] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:14];
    
    //validation of annual income
    if (![ValidationUtilty validNumber:[[UITextFieldsArray objectAtIndex:13] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:13];
    
    //validation of rent amount
    if(![ValidationUtilty validNumber:[[UITextFieldsArray objectAtIndex:16] text]])
         [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:16];
    
    //validation of ZipCode
    if (![ValidationUtilty validateZipCode:[[UITextFieldsArray objectAtIndex:12] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:12];
    
    //validation of Gender
    if (![ValidationUtilty validateGender:[[UITextFieldsArray objectAtIndex:6] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:6];
    
    //validation of DOB
    if (![ValidationUtilty validateDate:[[UITextFieldsArray objectAtIndex:3] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:3];
    
    //validation of issue date
    if (![ValidationUtilty validateDate:[[UITextFieldsArray objectAtIndex:4] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:4];
    //validation of expiry date
    if (![ValidationUtilty validateDate:[[UITextFieldsArray objectAtIndex:5] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:5];
    
    //validation of first name
    if (![ValidationUtilty validateUserName:[[UITextFieldsArray objectAtIndex:1] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:1];
    
    //validation of last name
    if(![ValidationUtilty validateUserName:[[UITextFieldsArray objectAtIndex:2] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:2];
    
    //validation of email
    if(![ValidationUtilty validateID:[[UITextFieldsArray objectAtIndex:0] text]])
        [isIncorrectField setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:0];

    
    return isIncorrectField;
}
@end
