//
//  WHShopOrderFoodModel.h
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHShopOrderFoodModel : NSObject
/// 食物名称
@property (nonatomic, copy) NSString *name;

+ (instancetype)shopOrderFoodWithDict:(NSDictionary *)dict;

@end
