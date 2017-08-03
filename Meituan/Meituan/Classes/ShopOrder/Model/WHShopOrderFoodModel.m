//
//  WHShopOrderFoodModel.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderFoodModel.h"

@implementation WHShopOrderFoodModel
+ (instancetype)shopOrderFoodWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"description"]) {
        _desc = value;
    }
    
    
    
    
}

@end
