//
//  ProductCollectionViewCell.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/17/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountedPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountPercentLabel;

@end
