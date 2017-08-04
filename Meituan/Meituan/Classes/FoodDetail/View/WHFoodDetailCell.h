//
//  WHFoodDetailCell.h
//  Meituan
//
//  Created by wh on 2017/8/4.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHShopOrderFoodModel;

@interface WHFoodDetailCell : UICollectionViewCell
@property (nonatomic, strong) WHShopOrderFoodModel *foodModel;
@end
