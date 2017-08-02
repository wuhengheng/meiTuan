//
//  WHInfoModel.h
//  Meituan
//
//  Created by wh on 2017/8/1.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHInfoModel : NSObject
/// 图标
@property (nonatomic, copy) NSString *icon_url;
/// 信息
@property (nonatomic, copy) NSString *info;

+ (instancetype)infoWithDict:(NSDictionary *)dict;
@end
