//
//  WHShopOrderCategoryModel.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderCategoryModel.h"
#import "WHShopOrderFoodModel.h"

@implementation WHShopOrderCategoryModel


+ (instancetype)shopOrderCategoryWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    
    // 判断当前是不是要给spus属性赋值
    if ([key isEqualToString:@"spus"]) {
        // 创建可变数组用来保存当前这一组中所有的食物
        NSMutableArray *foodsArrM = [NSMutableArray arrayWithCapacity:[value count]];
        for (NSDictionary *foodDict in value) {
            WHShopOrderFoodModel *foodModel = [WHShopOrderFoodModel shopOrderFoodWithDict:foodDict];
            [foodsArrM addObject:foodModel];
        }
        
        // 把食物模型数组赋值给spus
        _spus = foodsArrM.copy;
        
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
