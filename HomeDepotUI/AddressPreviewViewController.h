//
//  AddressPreviewViewController.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/29/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDetails.h"

@interface AddressPreviewViewController : UIViewController
@property (strong,nonatomic) CustomerDetails *customerDetails;

@property (weak, nonatomic) IBOutlet UIButton *buttonFour;
@property (weak, nonatomic) IBOutlet UIImageView *buttonFourImage;

@end
