//
//  WHNavigationBar.m
//  Meituan
//
//  Created by wh on 2017/7/31.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHNavigationBar.h"

@implementation WHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
if (self) {
    
    // 下面两行导航会让导航条彻底透明没有阴影线
    [self setShadowImage:[UIImage new]];
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    
    // 创建一个imageView来让导航条样式,将要修改此控件的透明度实现渐变效果
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_navigationBar_white"]];
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    _bgImageView = bgImageView;
    
}
return self;
}









@end
