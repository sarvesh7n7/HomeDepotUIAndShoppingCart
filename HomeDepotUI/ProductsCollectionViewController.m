//
//  ProductsCollectionViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/16/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "ProductsCollectionViewController.h"
#import "ProductDetails.h"
#import "ProductDetailViewController.h"
#import "ProductCollectionViewCell.h"
#import "VCHolder.h"
#import "UIViewController+AMSlideMenu.h"
#import "BBBadgeBarButtonItem.h"
#import "ShoppingCart.h"

@interface ProductsCollectionViewController ()
@property (weak, nonatomic) IBOutlet CHTCollectionViewWaterfallLayout *waterfallLayout;
@property (strong, nonatomic) ProductDetails *productDetails;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;

@end

@implementation ProductsCollectionViewController{
    VCHolder *myHolder;
    BBBadgeBarButtonItem *barButton;
    ShoppingCart *myCart;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    myCart = [ShoppingCart getInstance];
    self.waterfallLayout.headerHeight = 10;
    self.waterfallLayout.footerHeight = 10;
    self.waterfallLayout.minimumColumnSpacing = 10;
    self.waterfallLayout.minimumInteritemSpacing = 10;
    self.waterfallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    myHolder = [VCHolder getInstance];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setupRightNavigationButtons];
}

-(void)viewWillAppear:(BOOL)animated {
    barButton.badgeValue = [NSString stringWithFormat:@"%d",myCart.totalQuantity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toCart:(id)sender {
    if(myHolder.VCArray.count>=1) {
        [self.navigationController pushViewController:[myHolder.VCArray objectAtIndex:0] animated:YES];
    }
    else {
        [self performSegueWithIdentifier:@"toCheckout" sender:sender];
    }
}

-(void) setupRightNavigationButtons {
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainVC configureRightMenuButton:rightBtn];
    [rightBtn addTarget:mainVC action:@selector(openRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *hamMenu = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:self.cartButton];
    // Set a value for the badge
    barButton.badgeValue = [NSString stringWithFormat:@"%d",myCart.totalQuantity];
    barButton.badgeMinSize = 5.0;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:hamMenu,barButton,nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"toProductDetail"]){
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        ProductDetailViewController *pdvc = [segue destinationViewController];
        pdvc.productDetails = self.productDetails;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollectionViewCell *cell;
   
    
    if(indexPath.row == 0) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    }
    if(indexPath.row == 1) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    }
    if(indexPath.row == 2) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
    }
    if(indexPath.row == 3) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell4" forIndexPath:indexPath];
    }
    if(indexPath.row == 4) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell5" forIndexPath:indexPath];
    }
    if(indexPath.row == 5){
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell6" forIndexPath:indexPath];
    }
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

   
    if(indexPath.row == 0)
       return CGSizeMake(100, 130);
    if(indexPath.row == 1)
        return CGSizeMake(100, 170);
    if(indexPath.row == 2)
        return CGSizeMake(100, 160);
    if(indexPath.row == 3)
        return CGSizeMake(100, 120);
    if(indexPath.row == 4)
        return CGSizeMake(100, 170);
    if(indexPath.row == 5)
        return CGSizeMake(100, 120);
    
    return CGSizeMake(177, 275);
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductCollectionViewCell *cell;
    cell = (ProductCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    self.productDetails = [[ProductDetails alloc] init];
    self.productDetails.image = cell.image.image;
    self.productDetails.name = cell.nameLabel.text;
    self.productDetails.actualPrice = cell.actualPriceLabel.text;
    self.productDetails.discountedPrice = cell.discountedPriceLabel.text;
    self.productDetails.percentDiscount = cell.discountPercentLabel.text;
    [self performSegueWithIdentifier:@"toProductDetail" sender:self];
}

@end
