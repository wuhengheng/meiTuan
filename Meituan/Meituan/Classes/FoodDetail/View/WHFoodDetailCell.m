//
//  WHFoodDetailCell.m
//  Meituan
//
//  Created by wh on 2017/8/4.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHFoodDetailCell.h"
#import "WHShopOrderFoodModel.h"

@interface WHFoodDetailCell ()

/// 配图
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
/// 食物名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 月售
@property (weak, nonatomic) IBOutlet UILabel *month_saled_contentLabel;
/// 价格
@property (weak, nonatomic) IBOutlet UILabel *min_priceLabel;
/// 详情
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

/// 百分比 好评率
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
/// 进度条来显示好评率
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end



@implementation WHFoodDetailCell

- (void)setFoodModel:(WHShopOrderFoodModel *)foodModel {
    _foodModel = foodModel;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:[foodModel.picture stringByDeletingPathExtension]]];
    
    _nameLabel.text = foodModel.name;
    
    _month_saled_contentLabel.text = foodModel.month_saled_content;
    
    _min_priceLabel.text = [@"¥ " stringByAppendingFormat:@"%@", @(foodModel.min_price)];
    
    _descLabel.text = foodModel.desc;
    
    
    // 计算好评率
    CGFloat percentage = foodModel.praise_num / (foodModel.praise_num + foodModel.tread_num);
    
    _percentageLabel.text = [NSString stringWithFormat:@"%.f%%", percentage * 100];
    
    // 设置进度
    _progressView.progress = percentage;
}


@end
