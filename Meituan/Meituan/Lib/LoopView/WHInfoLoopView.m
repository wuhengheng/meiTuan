//
//  WHInfoLoopView.m
//  Meituan
//
//  Created by wh on 2017/8/2.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHInfoLoopView.h"
#import "WHInfoView.h"
@interface WHInfoLoopView ()
@property (nonatomic, weak) WHInfoView *infoView1;
@property (nonatomic, weak) WHInfoView *infoView2;
/// 显示第几条数据
@property (nonatomic, assign) NSInteger currentIndex;

@end
@implementation WHInfoLoopView
-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    // 第一个infoView
    WHInfoView *infoView1 = [[WHInfoView alloc] init];
    [self addSubview:infoView1];
    
    [infoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.offset(-16);
    }];
    
    // 第二个infoView
    WHInfoView *infoView2 = [[WHInfoView alloc] init];
    [self addSubview:infoView2];
    
    [infoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView1).offset(0);
        make.width.height.equalTo(infoView1);
        make.top.equalTo(infoView1.mas_bottom).offset(0);
    }];
    
    _infoView1 = infoView1;
    _infoView2 = infoView2;
}

- (void)setDiscounts:(NSArray<WHInfoModel *> *)discounts {
    _discounts = discounts;
    
    // 设置数据
    [self settingData];
    
    // 滚动
    [self scroll];
    
}

#pragma mark - 设置数据
- (void)settingData { 
    
    _infoView1.infoModel = _discounts[_currentIndex]; // infoView1 显示当前数据
    _infoView2.infoModel = _discounts[(_currentIndex + 1) % 7]; // 显示下一条数据
    //    }
}

#pragma mark - 滚动的
- (void)scroll {
    
    // 延迟两秒之后去滚动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 动画的方式整体向上滚动
        [UIView animateWithDuration:0.5 animations:^{
            
            _infoView1.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
            _infoView2.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
            
            
        } completion:^(BOOL finished) {
            // 让索引++ 准备显示整体向下一条显示
            _currentIndex = (_currentIndex + 1) % 7;
            // 重新设置数据
            [self settingData];
            
            // 让两个infoView都回到初始位置
            _infoView1.transform = CGAffineTransformIdentity;
            _infoView2.transform = CGAffineTransformIdentity;
            
            // 滚动
            [self scroll];
        }];
        
        
        
    });
    
}



@end
