//
//  WHInfoModel.m
//  Meituan
//
//  Created by wh on 2017/8/1.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHInfoModel.h"

@implementation WHInfoModel
+ (instancetype)infoWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
