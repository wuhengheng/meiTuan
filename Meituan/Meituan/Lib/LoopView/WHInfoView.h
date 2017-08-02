//
//  WHInfoView.h
//  Meituan
//
//  Created by wh on 2017/8/2.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHInfoModel;

@interface WHInfoView : UIView
/// 优惠信息模型
@property (nonatomic, strong) WHInfoModel *infoModel;
@end
