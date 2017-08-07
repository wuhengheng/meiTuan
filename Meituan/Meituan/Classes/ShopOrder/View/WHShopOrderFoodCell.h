//
//  WHShopOrderFoodCell.h
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHShopOrderFoodModel,WHShopOrderCountView;
@interface WHShopOrderFoodCell : UITableViewCell
/// 食物模型
@property (nonatomic, strong) WHShopOrderFoodModel *foodModel;

@property (nonatomic, weak) WHShopOrderCountView *countView;

@end
