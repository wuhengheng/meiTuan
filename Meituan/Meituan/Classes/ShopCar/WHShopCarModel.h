//
//  WHShopCarModel.h
//  Meituan
//
//  Created by wh on 2017/8/7.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WHShopOrderFoodModel;

@interface WHShopCarModel : NSObject



/// 保存所有选购的食物模型
@property (nonatomic, strong) NSMutableArray<WHShopOrderFoodModel *> *foodModelArray;

@end
