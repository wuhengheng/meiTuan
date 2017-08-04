//
//  WHFoodDetailController.h
//  Meituan
//
//  Created by wh on 2017/7/30.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHBaseController.h"
@class WHShopOrderCategoryModel;

@interface WHFoodDetailController : WHBaseController
/// 接收所有食物数据
@property (nonatomic, strong) NSArray<WHShopOrderCategoryModel *> *categoryData;
@end
