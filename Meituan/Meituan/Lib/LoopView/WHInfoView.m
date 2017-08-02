//
//  WHInfoView.m
//  Meituan
//
//  Created by wh on 2017/8/2.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHInfoView.h"
#import "WHInfoModel.h"


@interface WHInfoView ()
/// 图标
@property (nonatomic, weak) UIImageView *iconView;
/// 优惠信息
@property (nonatomic, weak) UILabel *infoLabel;
@end

@implementation WHInfoView


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
    
    // 1.图标
    UIImageView *iconView = [[UIImageView alloc] init];
    
    [self addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.equalTo(iconView.mas_height);
    }];
    
    
    // 2.优惠信息
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.text = @"大家都吃吧,不要钱还倒贴!";
    [self addSubview:infoLabel];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(8);
        make.centerY.offset(0);
    }];
    
    _iconView = iconView;
    _infoLabel = infoLabel;
}


- (void)setInfoModel:(WHInfoModel *)infoModel {
    _infoModel = infoModel;
    // 图标
    [_iconView sd_setImageWithURL:[NSURL URLWithString:infoModel.icon_url]];
    // 优惠信息
    _infoLabel.text = infoModel.info;
    
}


@end
