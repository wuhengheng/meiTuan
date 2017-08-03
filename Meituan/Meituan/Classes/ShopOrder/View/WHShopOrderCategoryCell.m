//
//  WHShopOrderCategoryCell.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderCategoryCell.h"
#import "WHShopOrderCategoryModel.h"


@implementation WHShopOrderCategoryCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    
    // 设置最多两行
    self.textLabel.numberOfLines = 2;
    // 设置字体
    self.textLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置背景颜色
    self.backgroundColor = [UIColor colorWithHex:0xefefef];
    
    // 给cell设置一个背景视图
    UIView *bgLineView = [[UIView alloc] init];
    bgLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashLineViewWithColor:[UIColor blackColor]]];
    self.backgroundView = bgLineView;
    
    [bgLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    
    
    // 设置选中的视图样式
    UIView *selectedBgView = [UIView new];
    selectedBgView.backgroundColor = [UIColor whiteColor];
    
    self.selectedBackgroundView = selectedBgView;
    
    // 添加小黄条
    UIView *lineYellowView = [UIView new];
    lineYellowView.backgroundColor = [UIColor primaryYellowColor];
    [selectedBgView addSubview:lineYellowView];
    
    [lineYellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.offset(0);
        make.width.offset(4);
        make.height.offset(44);
    }];
    
    
    
    
    
    
    
    
}



- (void)setCategoryModel:(WHShopOrderCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    self.textLabel.text = categoryModel.name;
}

@end
