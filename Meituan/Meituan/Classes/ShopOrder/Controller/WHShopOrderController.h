//
//  WHShopOrderController.h
//  Meituan
//
//  Created by wh on 2017/7/31.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHShopOrderCategoryModel;

@interface WHShopOrderController : UIViewController
/// 接收全部食物模型数据
@property (nonatomic, strong) NSArray<WHShopOrderCategoryModel *> *categoryData;
@end
