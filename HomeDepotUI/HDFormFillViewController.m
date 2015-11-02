//
//  HDFormFillViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 11/19/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "HDFormFillViewController.h"
#import "HDFormSummeryViewController.h"
#import "KeyboardDelegates.h"

typedef enum {
    yes,
    no,
} ZipFlag;

@interface HDFormFillViewController ()

@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labelArray;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *testFieldArray;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet KeyboardDelegates *keyboardDelegates;


//Custom variables


//individual text fields;
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *DOB;
@property (weak, nonatomic) IBOutlet UITextField *issueDate;
@property (weak, nonatomic) IBOutlet UITextField *expiryDate;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *licenseClass;
@property (weak, nonatomic) IBOutlet UITextField *streetNumber;
@property (weak, nonatomic) IBOutlet UITextField *streetName;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UITextField *income;
@property (weak, nonatomic) IBOutlet UITextField *SSN;
@property (weak, nonatomic) IBOutlet UITextField *rentOrOwn;
@property (weak, nonatomic) IBOutlet UITextField *rentAmount;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *emailID;

@end

@implementation HDFormFillViewController{
     ZipFlag isZipValid;
}

UIGestureRecognizer *tapper;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isZipValid = no;
        
    //setting up the border color to while for Label and Textfield
    [self colorFieldsBorderWithWhite];
    
    
    //logic to dimiss keyboard when tapped in areas other than text field;
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    //register of keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardDelegates];
    [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardDelegates];

}
- (void)viewWillAppear:(BOOL)animated{

    //register of keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self.keyboardDelegates
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.keyboardDelegates
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //setting the input type of DOB , Expiry Date and Issue Date to Date Picker
    [self.keyboardDelegates initializeDatePickersForDateFields];
    //[self initializeDatePickersForDateFields];
    //set up gender and rent/own picker array
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleSingleTap:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will ;often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"in perpare for segue");
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    HDFormSummeryViewController *dvc = [segue destinationViewController];
    [self initializeUserDetails];
    dvc.userDetails =self.userDetails;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onSubmitClick:(id)sender {
    [self performValidationsAndSegueWithSender:sender];
}

-(void) performValidationsAndSegueWithSender: (id) sender{
    
    //check and highlight the blank fields.
    if([ValidationUtilty isAnyFieldBlankIn:self.testFieldArray])
        [self displayAlertForFields:[ValidationUtilty getBlankFieldsLocation:self.testFieldArray] withInitialString:@"This Fields Are left Blank:"];
    else if([ValidationUtilty isAnyFieldIncorrect:[ValidationUtilty getIncorrectFieldsLocation:self.testFieldArray]])
        [self displayAlertForFields:[ValidationUtilty getIncorrectFieldsLocation:self.testFieldArray] withInitialString:@"This Fields Are Incorrect:"];
   // else if([self.keyboardDelegates did])
    else if(![ValidationUtilty  isexpiryDate: [[self.testFieldArray objectAtIndex:5] text] laterThanIssue:[[self.testFieldArray objectAtIndex:4] text]]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Form" message:@"Expiry Date earlier than Issue Date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
        [self performSegueWithIdentifier:@"toSummeryForm" sender:sender];
}


#pragma mark -  helper methods

-(void) initializeUserDetails {
    
    self.userDetails.userID = [[self.testFieldArray objectAtIndex:0] text];
    self.userDetails.firstNane = [[self.testFieldArray objectAtIndex:1] text];
    self.userDetails.lastName = [[self.testFieldArray objectAtIndex:2] text];
    self.userDetails.DOB = [[self.testFieldArray objectAtIndex:3] text];
    self.userDetails.issueDate = [[self.testFieldArray objectAtIndex:4] text];
    self.userDetails.expiryDate = [[self.testFieldArray objectAtIndex:5] text];
    self.userDetails.gender = [[self.testFieldArray objectAtIndex:6] text];
    self.userDetails.licenseClass = [[self.testFieldArray objectAtIndex:7] text];
    self.userDetails.streetNumber = [[self.testFieldArray objectAtIndex:8] text];
    self.userDetails.streetName = [[self.testFieldArray objectAtIndex:9]text];
    self.userDetails.city = [[self.testFieldArray objectAtIndex:10] text];
    self.userDetails.state = [[self.testFieldArray objectAtIndex:11] text];
    self.userDetails.zipCode = [[self.testFieldArray objectAtIndex:12] text];
    self.userDetails.annualIncome = [[self.testFieldArray objectAtIndex:13] text];
    self.userDetails.ssnNumber = [[self.testFieldArray objectAtIndex:14] text];
    self.userDetails.rentOrOwn = [[self.testFieldArray objectAtIndex:15] text];
    self.userDetails.monthlyRent = [[self.testFieldArray objectAtIndex:16] text];
    self.userDetails.phoneNumber = [[self.testFieldArray objectAtIndex:17] text];
    self.userDetails.emailID = [[self.testFieldArray objectAtIndex:18] text];
    
}



-(void) displayAlertForFields: (NSMutableArray*)blankFields withInitialString: (NSString*) initialString{
    //
    int i=0;
    NSMutableString *alertString = [NSMutableString stringWithString:initialString];
    for( NSNumber *currentField in blankFields){
        if([currentField boolValue] == YES){
            [alertString appendString:[NSString stringWithFormat:@"\n%@", [[self.labelArray objectAtIndex:i] text]]];
            [[self.testFieldArray objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
            
        }
         i++;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Form" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) colorFieldsBorderWithWhite{
    for( UILabel *currentLabel in self.labelArray){
        [currentLabel.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [currentLabel.layer setBorderWidth: 1.0];
    }
    
    for( UILabel *currentTextField in self.testFieldArray){
        [currentTextField.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [currentTextField.layer setBorderWidth: 1.0];
    }
}

@end

