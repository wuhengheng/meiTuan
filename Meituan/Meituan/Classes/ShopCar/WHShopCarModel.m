//
//  WHShopCarModel.m
//  Meituan
//
//  Created by wh on 2017/8/7.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopCarModel.h"

@implementation WHShopCarModel

// 给模型中的属性进行实例化
- (NSMutableArray<WHShopOrderFoodModel *> *)foodModelArray {
    if (_foodModelArray == nil) {
        _foodModelArray = [NSMutableArray array];
    }
    return _foodModelArray;
}
@end
