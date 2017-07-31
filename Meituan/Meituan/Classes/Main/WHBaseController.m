//
//  WHBaseController.m
//  Meituan
//
//  Created by wh on 2017/7/30.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHBaseController.h"
#import "WHNavigationController.h"
#import "WHNavigationBar.h"

@interface WHBaseController ()

@end

@implementation WHBaseController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 为每一个继承至此类的控制器都添加一个导航条
        WHNavigationBar *navBar = [[WHNavigationBar alloc] init];
        
        // 给导航条添加UINavigationItem
        UINavigationItem *navItem = [[UINavigationItem alloc] init];
        // 把UINavigationItem设置到导航条上'建立它和导航条控件的关系'
        [navBar setItems:@[navItem]];
        
        _navBar = navBar;
        
        _navItem = navItem;
        
        
        
        
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 把导航条添加到控制器的view上
    [self.view addSubview:_navBar];
    // 设置导航条的约束
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(64);
    }];
    
}






// 内存警告处理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (self.isViewLoaded && self.view.window == nil) {
        
        self.view = nil;
    }
}



// 重写此属性的set方法,此方法调用说明有人想要换状态栏
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    // 让设置状态栏样式的方法重新调用
    [self setNeedsStatusBarAppearanceUpdate];
}

// 设置状态栏式
- (UIStatusBarStyle)preferredStatusBarStyle {
    NSLog(@"---");
    return self.statusBarStyle;
}

@end
