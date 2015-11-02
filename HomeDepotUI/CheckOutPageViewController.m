//
//  CheckOutPageViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/19/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "CheckOutPageViewController.h"
#import "PriceDetailsTableViewCell.h"
#import "VCHolder.h"



@interface CheckOutPageViewController (){
    NSArray *keysArray;
    VCHolder *myHolder;
    UIGestureRecognizer *tapper;
}

//@property (strong, nonatomic) ProductDetailTableViewCell *productCell;
@property (strong, nonatomic) PriceDetailsTableViewCell *priceCell;
@property (strong, nonatomic) PromoCodeTableViewCell *promoCodeCell;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;



@end

@implementation CheckOutPageViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.shoppingCart = [ShoppingCart getInstance];
    
    // Do any additional setup after loading the view.
    
    //logic to dimiss keyboard when tapped in areas other than text field;
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];

    //add the loaded View controller to the VCHolder Array
    myHolder = [VCHolder getInstance];
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [myHolder.VCArray addObject:self];
    });
    
}

- (void)viewWillDisappear:(BOOL)animated{
    //register of keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated{
      //[self.myTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    //register of keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    keysArray = [self.shoppingCart.productInfo allKeys];
    [self.myTableView reloadData];
    //setting the input type of DOB , Expiry Date and Issue Date to Date Picker
    //[self initializeDatePickersForDateFields];
    //set up gender and rent/own picker array
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return (self.shoppingCart.productQuantity.count + 3);
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    //  NSLog(@"The count: %d",[categoryDetails count]);
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    //fist section
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"checkoutCell" forIndexPath:indexPath];
        return cell;
    }
    
    //last section
    else if(indexPath.section == self.shoppingCart.productQuantity.count + 2){
        
        self.promoCodeCell = [tableView dequeueReusableCellWithIdentifier:@"promoCell" forIndexPath:indexPath];
        self.promoCodeCell.subtotalLabel.text = [NSString stringWithFormat:@"SUBTOTAL: $%.2f",self.shoppingCart.discountedTotal];
        self.promoCodeCell.delegate = self;
        return self.promoCodeCell;
    }
    
    //second last section
    else if(indexPath.section == self.shoppingCart.productQuantity.count + 1){
        self.priceCell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        [self.shoppingCart calculateMerchadiseTotal];
        self.priceCell.totalQuantityLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCart.totalQuantity];
        self.priceCell.merchandiseTotalLabel.text = [NSString stringWithFormat:@"$%.2f",self.shoppingCart.merchandiseTotal];
         self.priceCell.discountLabel.text = [NSString stringWithFormat:@"%@",[self.shoppingCart getCouponValue]];
        return self.priceCell;
    }
    
    else {
        ProductDetailTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
        NSString *currentName = [keysArray objectAtIndex:indexPath.section-1];
        
        productCell.productImageView.image = [[self.shoppingCart.productInfo objectForKey:currentName] image];
        
        productCell.nameLabel.text = [[self.shoppingCart.productInfo objectForKey:currentName] name];
        productCell.priceLabel.text = [[self.shoppingCart.productInfo objectForKey:currentName] discountedPrice];
        
        productCell.quantityLabel.text =[[self.shoppingCart.productQuantity objectForKey:currentName] stringValue];
        productCell.quantityTextField.text = productCell.quantityLabel.text;
        productCell.delegate = self;
        return productCell;
    }
    
   // return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13; // you can have your own choice, of course
}


/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 186;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   
    

    return cell.frame.size.height;
}
 
 */


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 186;
}
#pragma mark - ProductDetailTableViewCell delegates methods

-(void)productDidIncrementByOne{
    self.priceCell.totalQuantityLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCart.totalQuantity];
    self.priceCell.merchandiseTotalLabel.text = [NSString stringWithFormat:@"$%.2f",self.shoppingCart.merchandiseTotal];
   // self.priceCell.discountLabel.text = [NSString stringWithFormat:@"%.2f",self.shoppingCart.discountedTotal];
    self.promoCodeCell.subtotalLabel.text = [NSString stringWithFormat:@"SUBTOTAL: $%.2f",self.shoppingCart.discountedTotal];
    self.priceCell.discountLabel.text = [self.shoppingCart getCouponValue];

}

-(void)productDidDecrementByOne{
    self.priceCell.totalQuantityLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCart.totalQuantity];
    self.priceCell.merchandiseTotalLabel.text = [NSString stringWithFormat:@"$%.2f",self.shoppingCart.merchandiseTotal];
    self.priceCell.discountLabel.text = [self.shoppingCart getCouponValue];
    self.promoCodeCell.subtotalLabel.text = [NSString stringWithFormat:@"SUBTOTAL: $%.2f",self.shoppingCart.discountedTotal];
}


-(void)productValueChangedto:(NSInteger)value{
    self.priceCell.totalQuantityLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCart.totalQuantity];
    self.priceCell.merchandiseTotalLabel.text = [NSString stringWithFormat:@"$%.2f",self.shoppingCart.merchandiseTotal];
    self.priceCell.discountLabel.text = [self.shoppingCart getCouponValue];
    self.promoCodeCell.subtotalLabel.text = [NSString stringWithFormat:@"SUBTOTAL: $%.2f",self.shoppingCart.discountedTotal];
}

-(void)didDeletedProduct:(ProductDetailTableViewCell *)productCell{
    
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:productCell];
    [self.myTableView beginUpdates];
    [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]  withRowAnimation: UITableViewRowAnimationNone];
    [self.myTableView endUpdates];
    self.priceCell.totalQuantityLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCart.totalQuantity];
    self.priceCell.merchandiseTotalLabel.text = [NSString stringWithFormat:@"$%.2f",self.shoppingCart.merchandiseTotal];
    self.priceCell.discountLabel.text = [self.shoppingCart getCouponValue];
    self.promoCodeCell.subtotalLabel.text = [NSString stringWithFormat:@"$SUBTOTAL: %.2f",self.shoppingCart.discountedTotal];
}




#pragma mark - PromoCodeTableViewCell delegates methods

-(void) didTappedApplyCoupon{
    self.priceCell.totalQuantityLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCart.totalQuantity];
    self.priceCell.merchandiseTotalLabel.text = [NSString stringWithFormat:@"$%.2f",self.shoppingCart.merchandiseTotal];
    self.priceCell.discountLabel.text = [self.shoppingCart getCouponValue];
    self.promoCodeCell.subtotalLabel.text = [NSString stringWithFormat:@"SUBTOTAL: $%.2f",self.shoppingCart.discountedTotal];
}

#pragma mark - Button tapped methods

- (IBAction)checkOutTapped:(id)sender {
    
    if(self.shoppingCart.totalQuantity ==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error:cart empty" message:@"there are no products in the cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if(myHolder.VCArray.count>=2){
            [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:1] animated:YES];
        }
        else{
            [self performSegueWithIdentifier:@"toAddress" sender:sender];
        }
    }
}

- (IBAction)oneTapped:(id)sender {
    
}

- (IBAction)twoTapped:(id)sender {
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:1] animated:YES];
}

- (IBAction)threeTapped:(id)sender {
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:1] animated:NO];
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:2] animated:YES];
   
}
- (IBAction)fourTapped:(id)sender {
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:1] animated:NO];
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:2] animated:NO];
    [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:3] animated:YES];
}

#pragma mark - keyboard notifications delegates

- (void) keyboardDidShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.myTableView.contentInset = contentInsets;
    self.myTableView.scrollIndicatorInsets = contentInsets;
    
}

- (void) keyboardWillBeHidden:(NSNotification *)notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myTableView.contentInset = contentInsets;
    self.myTableView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//dismis keyboard when tapped in other areas

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
