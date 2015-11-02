//
//  KeyboardDelegates.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/5/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "KeyboardDelegates.h"
#import "Constants.h"


@interface KeyboardDelegates ()

//datePickers variables
@property (strong, nonatomic)  UIDatePicker *DOBDatePicker;
@property (strong, nonatomic)  UIDatePicker *IssueDatePicker;
@property (strong, nonatomic)  UIDatePicker *ExpiryDatePicker;

@end

@implementation KeyboardDelegates{
    
    UIPickerView *genderAndAmoutTypePickerView;
    NSArray *rentArray;
    NSArray *genderArray;
}


#pragma mark - Text field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField;
    textField.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    //selectedTextfieldValue = (int)textField.tag;
    
    // call picker here according to textfield tag you can set text to textfiled
    
    if (textField.tag == kgender || textField.tag ==krentorown)
       // [self popoverWithInformation];
        [self initializeCustomPickerForTextFieldWithTag:textField.tag];
}



- (IBAction)textFieldDidEndEditing:(UITextField *)sender{
    if(sender.tag == kzipcode) {
        if([sender.text length] <5) {
            self.cityTextField.text = @"";
            self.stateTextField.text = @"";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Form" message:@"Invalid Zip Code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    self.activeField = nil;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField.tag == kphonenumber)
        return [self phoneNumberTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    else if(textField.tag == kssnno)
        return [self SSNNumberTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    else if(textField.tag == kincome || textField.tag == krentamount)
        return [self anyAmountTextField:textField shouldChangeCharactersInRange:range replacementString:string];
   
    else if(textField.tag == kzipcode)
        return [self ZipCodeTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    else if(textField.tag == kdob || textField.tag == kissuedate || textField.tag == kexpirydate || textField.tag == kgender || textField.tag == krentorown)
        return NO;
    
    return YES;
}


-(BOOL) anyAmountTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init] ;
    if (range.length == 0 && ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]])
        return NO;
    
    if([string length]==0) {
        [formatter setGroupingSeparator:@","];
        [formatter setGroupingSize:4];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setSecondaryGroupingSize:3];
        NSString *num = textField.text ;
        num = [num stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString *str = [formatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
        textField.text = str;
        return YES;
    }
    else {
        [formatter setGroupingSeparator:@","];
        [formatter setGroupingSize:2];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setSecondaryGroupingSize:3];
        NSString *num = textField.text ;
        if(![num isEqualToString:@""]) {
            num = [num stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *str = [formatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
            textField.text = str;
            //NSLog(@"add:%@",str);
        }
        return YES;
    }
}

-(BOOL) phoneNumberTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 12)
        return NO;
    
    // Reject appending non-digit characters
    if (range.length == 0 && ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]])
        return NO;
    
    
    // Auto-add hyphen before appending 4rd or 7th digit
    if (range.length == 0 && (range.location == 3 || range.location == 7)) {
        textField.text = [NSString stringWithFormat:@"%@-%@", textField.text, string];
        return NO;
    }
    
    // Delete hyphen when deleting its trailing digit
    if (range.length == 1 && (range.location == 4 || range.location == 8)) {
        range.location--;
        range.length = 2;
        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
    return YES;
}

-(BOOL) ZipCodeTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
   // NSLog(@"LOCATION: %lu",(unsigned long)range.location);
   // NSLog(@"LENGTH: %lu",(unsigned long)range.length);
    if (range.location == 5)
        return NO;
    if(range.location == 4 && range.length ==0) {
        NSString *zipString = [NSString stringWithFormat:@"%@%@",textField.text,string];
      //  NSLog(@"%@",zipString);
        [self didEnterZip:zipString];
    }
    return YES;

}

-(BOOL) SSNNumberTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 11)
        return NO;
    
    // Reject appending non-digit characters
    if (range.length == 0 && ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]])
        return NO;
    
    
    // Auto-add hyphen before appending 4rd or 7th digit
    if (range.length == 0 && (range.location == 3 || range.location == 6)) {
        textField.text = [NSString stringWithFormat:@"%@-%@", textField.text, string];
        return NO;
    }
    
    // Delete hyphen when deleting its trailing digit
    if (range.length == 1 && (range.location == 4 || range.location == 7)) {
        range.location--;
        range.length = 2;
        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
    return YES;
    
}

#pragma mark - pickerView Delegates methods

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *rowString;
    if (pickerView.tag==0)
        rowString =  [genderArray objectAtIndex:row];
    
    else if (pickerView.tag==1)
        rowString =  [rentArray objectAtIndex:row];
    
    return rowString;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    
    NSString *rowString;
    
    if (pickerView.tag==0) {
        rowString =  [genderArray objectAtIndex:row];
        self.genderTextField.text = rowString;
    }

    else if (pickerView.tag==1) {
        rowString =  [rentArray objectAtIndex:row];
        self.rentOrOwnTextField.text = rowString;
    }
}

#pragma mark - keyboard notifications delegates
- (void) keyboardDidShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark - helper methods

-(void) initializeDatePickersForDateFields {
    NSDate *currentDate = [NSDate date];
    NSDateComponents *dateYearComponent = [[NSDateComponents alloc] init];
    [dateYearComponent setYear:-100];
    
    
    self.DOBDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.DOBDatePicker setDatePickerMode:UIDatePickerModeDate];
    NSDate *minDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateYearComponent toDate:currentDate options:0];
    self.DOBDatePicker.minimumDate = minDate;
    self.DOBDatePicker.maximumDate = currentDate;
    [self.DOBDatePicker addTarget:self action:@selector(DOBDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.DOBTextField.inputView = self.DOBDatePicker;
    
    [dateYearComponent setYear:-20];
    self.IssueDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.IssueDatePicker setDatePickerMode:UIDatePickerModeDate];
    minDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateYearComponent toDate:currentDate options:0];
    self.IssueDatePicker.minimumDate = minDate;
    self.IssueDatePicker.maximumDate = [NSDate date];
    [self.IssueDatePicker addTarget:self action:@selector(IssueDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.IssueDateTextField.inputView = self.IssueDatePicker;
    
    [dateYearComponent setYear:20];
    self.ExpiryDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.ExpiryDatePicker setDatePickerMode:UIDatePickerModeDate];
    self.ExpiryDatePicker.minimumDate = [NSDate date];
    NSDate* maxDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateYearComponent toDate:currentDate options:0];
    self.ExpiryDatePicker.maximumDate = maxDate;
    [self.ExpiryDatePicker addTarget:self action:@selector(ExpiryDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.ExpiryDateTextField.inputView = self.ExpiryDatePicker;
}

-(void)DOBDatePickerValueChanged:(UIDatePicker *)datePicker {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    self.DOBTextField.text = [dateFormatter stringFromDate:datePicker.date];
}

-(void)IssueDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    self.IssueDateTextField.text = [dateFormatter stringFromDate:datePicker.date];
}

-(void)ExpiryDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    self.ExpiryDateTextField.text = [dateFormatter stringFromDate:datePicker.date];
    
}

-(void) initializeCustomPickerForTextFieldWithTag: (NSInteger) tag {
    rentArray=[[NSArray alloc]initWithObjects:@"",@"rent",@"Own", nil];
    genderArray=[[NSArray alloc]initWithObjects:@"",@"Male",@"Female", nil];
    
    genderAndAmoutTypePickerView = [[UIPickerView alloc] init];
    genderAndAmoutTypePickerView.delegate = self;
    genderAndAmoutTypePickerView.showsSelectionIndicator = YES;
    if (tag == kgender){
        self.genderTextField.inputView = genderAndAmoutTypePickerView;
        genderAndAmoutTypePickerView.tag = 0;
    }
    
    else if (tag == krentorown) {
        self.rentOrOwnTextField.inputView = genderAndAmoutTypePickerView;
        genderAndAmoutTypePickerView.tag = 1;
    }
    [genderAndAmoutTypePickerView selectRow:[self rowIndexForGenderAndAmountTypePickerForTextField] inComponent:0 animated:YES];
}


-(NSInteger) rowIndexForGenderAndAmountTypePickerForTextField {
    if (genderAndAmoutTypePickerView.tag == 0) {
        for(int i=0; i<genderArray.count;i++) {
           if([genderArray[i] isEqualToString:self.genderTextField.text])
               return i;
       }
    }
    
    else if (genderAndAmoutTypePickerView.tag == 1){
        for(int i=0; i<rentArray.count;i++){
            if([rentArray[i] isEqualToString:self.rentOrOwnTextField.text])
                return i;
        }
    }
    return 0;
}

- (void)didEnterZip:(NSString*)zip {
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [geoCoder geocodeAddressDictionary:@{
                                         (NSString*)kABPersonAddressZIPKey : zip,
                                         (NSString*)kABPersonAddressCountryCodeKey : @"US"
                                         }
                     completionHandler:^(NSArray *placemarks, NSError *error) {
                         if ([placemarks count] > 0) {
                             CLPlacemark* placemark = [placemarks objectAtIndex:0];
                             
                             NSString* city = placemark.addressDictionary[(NSString*)kABPersonAddressCityKey];
                             NSString* state = placemark.addressDictionary[(NSString*)kABPersonAddressStateKey];
                             
                             self.cityTextField.text = city;
                             self.cityTextField.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
                             
                             self.stateTextField.text = state;
                             self.stateTextField.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
                             
                         }   else {
                             self.cityTextField.text = @"";
                             self.stateTextField.text = @"";
                             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Form" message:@"Invalid Zip Code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                         }
                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                     }];
}




@end
