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
///配图
@property (nonatomic, copy) NSString *picture;
///食物描述
@property (nonatomic, copy) NSString *_description;
///月售
@property (nonatomic, copy) NSString *month_saled_content;
///点赞
@property (nonatomic, copy) NSString *praise_content;
///价格
@property (nonatomic, copy) NSString *min_price;


+ (instancetype)shopOrderFoodWithDict:(NSDictionary *)dict;

@end
