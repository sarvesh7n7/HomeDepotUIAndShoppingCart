//
//  KeyboardDelegates.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/5/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface KeyboardDelegates : NSObject <UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;

@property (weak, nonatomic) IBOutlet UITextField *DOBTextField;
@property (weak, nonatomic) IBOutlet UITextField *IssueDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *ExpiryDateTextField;

@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *rentOrOwnTextField;



- (void) keyboardDidShow:(NSNotification *)notification;
- (void) keyboardWillBeHidden:(NSNotification *)notification;
- (void) initializeDatePickersForDateFields;


@end
