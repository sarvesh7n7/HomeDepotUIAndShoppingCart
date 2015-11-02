//
//  ProductsCollectionViewController.h
//  HomeDepotUI
//
//  Created by Sarvesh Joshi on 12/16/14.
//  Copyright (c) 2014 RapidValueSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"


@interface ProductsCollectionViewController : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>

@end
