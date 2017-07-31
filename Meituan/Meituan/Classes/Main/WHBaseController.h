//
//  WHBaseController.h
//  Meituan
//
//  Created by wh on 2017/7/30.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHNavigationBar;


@interface WHBaseController : UIViewController

// 导航条
@property (nonatomic, strong, readonly) WHNavigationBar *navBar;


// navItem
@property (nonatomic, strong, readonly) UINavigationItem *navItem;

// 状态栏样式
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@end
