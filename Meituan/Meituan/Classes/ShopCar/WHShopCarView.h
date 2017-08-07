//
//  HMShopCarView.h
//  HMWaiMai
//
//  Created by apple on 2017/8/5.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHShopCarModel;

@interface WHShopCarView : UIView

/// 购物车模型
@property (nonatomic, strong) WHShopCarModel *shopCarModel;

+ (instancetype)shopCarView;

- (void)animWithStartPoint:(CGPoint)startPoint;

@end
