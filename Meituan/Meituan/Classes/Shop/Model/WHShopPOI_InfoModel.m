//
//  WHShopPOI_InfoModel.m
//  Meituan
//
//  Created by wh on 2017/8/1.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopPOI_InfoModel.h"
#import "WHInfoModel.h"

@implementation WHShopPOI_InfoModel
+ (instancetype)shopPOI_infoWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

/// 重写此方法可以解决 模型属性比字典中key少的问题
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    // 判断抛出的key是不是我们想要的
    if ([key isEqualToString:@"discounts2"]) {
        // 所有优惠信息
        NSArray *discountsArray = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:discountsArray.count];
        for (NSDictionary *dict in discountsArray) {
            WHInfoModel *infoModel = [WHInfoModel infoWithDict:dict];
            [arrM addObject:infoModel];
        }
        // 给模型属性赋值
        _discounts = arrM.copy;
        
    }
}

@end
