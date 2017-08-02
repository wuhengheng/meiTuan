//
//  WHInfoLoopView.h
//  Meituan
//
//  Created by wh on 2017/8/2.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHInfoModel;

@interface WHInfoLoopView : UIView
/// 所有优惠信息的数据
@property (nonatomic, strong) NSArray<WHInfoModel *> *discounts;

@end
