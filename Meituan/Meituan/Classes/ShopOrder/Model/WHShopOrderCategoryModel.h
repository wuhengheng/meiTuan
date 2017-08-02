//
//  WHShopOrderCategoryModel.h
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WHShopOrderFoodModel;

@interface WHShopOrderCategoryModel : NSObject


/// 食物类别
@property (nonatomic, copy) NSString *name;

/// 保存当前类别的所有食物
@property (nonatomic, strong) NSArray<WHShopOrderFoodModel *> *spus;

+ (instancetype)shopOrderCategoryWithDict:(NSDictionary *)dict;
@end
