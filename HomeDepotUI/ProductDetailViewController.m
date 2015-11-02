//
//  ProductDetailViewController.m
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/17/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ShoppingCart.h"
#import "NetworkRequests.h"
#import "VCHolder.h"
#import "UIViewController+AMSlideMenu.h"
#import "BBBadgeBarButtonItem.h"

@interface ProductDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountedPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountPercentLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cartButton;
@property (weak, nonatomic) IBOutlet UIButton *cartButtonSub;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;



@end

@implementation ProductDetailViewController{
    ShoppingCart *myCart;
    VCHolder *myHolder;
    BBBadgeBarButtonItem *barButton;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    myCart = [ShoppingCart getInstance];
    self.productImageView.image = self.productDetails.image;
    self.nameLabel.text = self.productDetails.name;
    self.actualPriceLabel.text = self.productDetails.actualPrice;
    self.discountedPriceLabel.text = self.productDetails.discountedPrice;
    self.discountPercentLabel.text = self.productDetails.percentDiscount;
    
    myHolder = [VCHolder getInstance];
    [self setupRightNavigationButtons];
}

-(void)viewWillAppear:(BOOL)animated {
    barButton.badgeValue = [NSString stringWithFormat:@"%d",myCart.totalQuantity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addToCart:(id)sender {
    [myCart addNewProductWithDetails:self.productDetails];
    barButton.badgeValue = [NSString stringWithFormat:@"%d",myCart.totalQuantity];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Product Added" message:@"The product in Added in your Card click on Cart Icon to procedd to checkout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [myCart displayAllProducts];
    CGMutablePathRef thePath = [self createBounceOnBorderPath:2];
    
   // CGMutablePathRef thePath  = CGPathCreateMutable();
    CGPoint thePoint = barButton.badge.center;
    
    
    CGPathAddCurveToPoint(thePath,NULL ,thePoint.x,thePoint.y-40.0,
                          thePoint.x,thePoint.y-40.0,
                          thePoint.x,thePoint.y);
    
    CGPathAddCurveToPoint(thePath,NULL ,thePoint.x,thePoint.y-20.0,
                          thePoint.x,thePoint.y-20.0,
                          thePoint.x,thePoint.y);
    
    CGPathAddCurveToPoint(thePath,NULL ,thePoint.x,thePoint.y-10.0,
                          thePoint.x,thePoint.y-10.0,
                          thePoint.x,thePoint.y);
    
    CAKeyframeAnimation * theAnimation;
    
    //cgpathadd
    
    // Create the animation object, specifying the position property as the key path.
    theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path=thePath;
    theAnimation.duration=3.0;
    theAnimation.calculationMode = kCAAnimationPaced;
    // Add the animation to the layer.
    [barButton.badge.layer addAnimation:theAnimation forKey:@"position"];
}

-(IBAction)goToCheckout:(id)sender{
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
    //myButton.imageView.image = [UIImage imageNamed:@"cart1.png"];
    barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:self.cartButtonSub];
    // Set a value for the badge
    barButton.badgeValue = [NSString stringWithFormat:@"%d",myCart.totalQuantity];
    barButton.badgeMinSize = 10.0;
    //barButton.b
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:hamMenu,barButton,nil];
    
    
}

-(CGMutablePathRef) createBounceOnBorderPath:(int) bounceNumber{
    
    CGMutablePathRef thisPath = CGPathCreateMutable();
    CGPoint badgeCenter = barButton.badge.center;
    CGPoint buttonCenter = self.addToCartButton.center;
    
    buttonCenter = [barButton.badge convertPoint:badgeCenter fromView:self.addToCartButton];
    BOOL isLeft = YES;
    float totalY = buttonCenter.y-badgeCenter.y;
    float totalX = buttonCenter.x;
    
  
    float heightInc = totalY/(bounceNumber/2);
    float rightYInc = buttonCenter.y;
    float leftYInc = buttonCenter.y-heightInc/2;
    //initialization of fist point
    CGPathMoveToPoint(thisPath,NULL,buttonCenter.x,buttonCenter.y);
    //CGPathAddLineToPoint(thisPath, NULL, totalX, rightYInc);
    
    for(int i=0;i<bounceNumber-1; i++){
        if(isLeft) {
            //draw from left to right.
            CGPathAddLineToPoint(thisPath, NULL, totalX, rightYInc);
            rightYInc = rightYInc-heightInc;
            isLeft = NO;
        }
        else {
            //draw from right to left.
            CGPathAddLineToPoint(thisPath, NULL, totalX+330, leftYInc);
            leftYInc = leftYInc-heightInc;
            isLeft = YES;
        }
    }
    CGPathAddLineToPoint(thisPath, NULL, badgeCenter.x, badgeCenter.y);
    return thisPath;
}


-(CGMutablePathRef) createSpiralPath:(int) bounceNumber{
    
    CGMutablePathRef thisPath = CGPathCreateMutable();
    CGPoint badgeCenter = barButton.badge.center;
    CGPoint buttonCenter = self.addToCartButton.center;
   
    buttonCenter = [barButton.badge convertPoint:badgeCenter fromView:self.addToCartButton];
   
    float totalY = buttonCenter.y-badgeCenter.y;
    float totalX = buttonCenter.x-badgeCenter.x;
    
    float xinc = (totalX/bounceNumber)-0.0;
    float yinc =  (totalY/bounceNumber)-0.0;
    CGPoint currntPoint = buttonCenter;
    CGPoint nextPoint;
    nextPoint.x = currntPoint.x-xinc;
    nextPoint.y = currntPoint.y-yinc;
    
    //initialization of fist point
    CGPathMoveToPoint(thisPath,NULL,buttonCenter.x,buttonCenter.y);
    //CGPathAddLineToPoint(thisPath, NULL, totalX, rightYInc);
    
    for(int i=0;i<bounceNumber; i++){
        CGPathAddCurveToPoint(thisPath, NULL, currntPoint.x+(xinc), currntPoint.y-(yinc), nextPoint.x+(xinc), nextPoint.y-(yinc),nextPoint.x, nextPoint.y);
        currntPoint = nextPoint;
        nextPoint.x = nextPoint.x - xinc;
        nextPoint.y = nextPoint.y - yinc;
    }
    
    return thisPath;
}

-(CGMutablePathRef) createSpiralPath1:(int) bounceNumber{
    
    CGMutablePathRef thisPath = CGPathCreateMutable();
    CGPoint badgeCenter = barButton.badge.center;
    CGPoint buttonCenter = self.addToCartButton.center;
    
    buttonCenter = [barButton.badge convertPoint:badgeCenter fromView:self.addToCartButton];
    
    float totalY = buttonCenter.y-badgeCenter.y;
    float totalX = buttonCenter.x-badgeCenter.x;
    
    float xinc = (totalX/bounceNumber)-0.0;
    float yinc =  (totalY/bounceNumber)-0.0;
    CGPoint currntPoint = buttonCenter;
    CGPoint nextPoint;
    nextPoint.x = currntPoint.x-xinc;
    nextPoint.y = currntPoint.y-yinc;
    
    
    //initialization of fist point
    CGPathMoveToPoint(thisPath,NULL,buttonCenter.x,buttonCenter.y);
    //CGPathAddLineToPoint(thisPath, NULL, totalX, rightYInc);
    
    for(int i=0;i<bounceNumber/2; i++){
        
        CGPathAddCurveToPoint(thisPath, NULL, currntPoint.x+(xinc), currntPoint.y-(yinc), nextPoint.x+(xinc), nextPoint.y-(yinc),nextPoint.x, nextPoint.y);
        currntPoint = nextPoint;
        nextPoint.x = nextPoint.x - xinc;
        nextPoint.y = nextPoint.y - yinc;
        CGPathAddCurveToPoint(thisPath, NULL, currntPoint.x-(xinc), currntPoint.y+(yinc), nextPoint.x-(xinc), nextPoint.y+(yinc),nextPoint.x, nextPoint.y);
        currntPoint = nextPoint;
        nextPoint.x = nextPoint.x - xinc;
        nextPoint.y = nextPoint.y - yinc;
    }
    return thisPath;
}

-(CGMutablePathRef) createSpiralPath2:(int) bounceNumber{
    
    CGMutablePathRef thisPath = CGPathCreateMutable();
    CGPoint badgeCenter = barButton.badge.center;
    CGPoint buttonCenter = self.addToCartButton.center;

    buttonCenter = [barButton.badge convertPoint:badgeCenter fromView:self.addToCartButton];
    
    float totalY = buttonCenter.y-badgeCenter.y;
    float totalX = buttonCenter.x-badgeCenter.x;
    float xinc = (totalX/bounceNumber)-0.0;
    float yinc =  (totalY/bounceNumber)-0.0;
    
    CGPoint currntPoint = buttonCenter;
    CGPoint nextPoint;
    nextPoint.x = currntPoint.x-xinc;
    nextPoint.y = currntPoint.y-yinc;
    
    float angle = atan2(yinc, xinc*-1);
    float endangle = 2*M_PI - angle;
    //float startangle = M_PI*3/2-angle;
    float startangle = M_PI-angle;

    
    //initialization of fist point
    CGPathMoveToPoint(thisPath,NULL,buttonCenter.x,buttonCenter.y);
    //CGPathAddLineToPoint(thisPath, NULL, totalX, rightYInc);
    
    
    for(int i=0;i<bounceNumber*2-1; i++){
        
        CGPathAddArc(thisPath, NULL, currntPoint.x-xinc/2, currntPoint.y-yinc/2, sqrt(xinc*xinc+yinc*yinc)/2, startangle,endangle, false);
        //CGPathAddArc(thisPath, NULL, nextPoint.x+xinc/2, nextPoint.y+yinc/2, sqrt((xinc*xinc+yinc*yinc)/2), 0, 2*M_PI, true);
        //CGPathAddArcToPoint(thisPath, NULL, <#CGFloat x1#>, <#CGFloat y1#>, <#CGFloat x2#>, <#CGFloat y2#>, sqrt(xinc*xinc+yinc*yinc)/2)
        
        CGPathAddArc(thisPath, NULL, currntPoint.x-xinc*3/4, currntPoint.y-yinc*3/4, sqrt(xinc*xinc+yinc*yinc)/4,  endangle,startangle, false);
        currntPoint.x = currntPoint.x - xinc/2;
        currntPoint.y = currntPoint.y - yinc/2;
        
    }
    return thisPath;
}


@end
