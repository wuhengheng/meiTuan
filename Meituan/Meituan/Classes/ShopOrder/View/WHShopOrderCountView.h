//
//  WHShopOrderCountView.h
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHShopOrderFoodModel;
@interface WHShopOrderCountView : UIView
@property (nonatomic, strong) WHShopOrderFoodModel *foodModel;

+ (instancetype)shopOrderCountView;
@end
