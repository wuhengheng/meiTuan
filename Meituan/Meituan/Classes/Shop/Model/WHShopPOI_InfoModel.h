//
//  WHShopPOI_InfoModel.h
//  Meituan
//
//  Created by wh on 2017/8/1.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WHInfoModel;
@interface WHShopPOI_InfoModel : NSObject

/// 头部背景图片
@property (nonatomic, copy) NSString *poi_back_pic_url;

/// 头像
@property (nonatomic, copy) NSString *pic_url;
/// 店名
@property (nonatomic, copy) NSString *name;
/// 商家公告
@property (nonatomic, copy) NSString *bulletin;

/// 优惠信息
@property (nonatomic, strong) NSArray<WHInfoModel *> *discounts;

/// 起送价
@property (nonatomic, copy) NSString *min_price_tip;

/// 配送费
@property (nonatomic, copy) NSString *shipping_fee_tip;

/// 配送时间
@property (nonatomic, copy) NSString *delivery_time_tip;

+ (instancetype)shopPOI_infoWithDict:(NSDictionary *)dict;
@end

