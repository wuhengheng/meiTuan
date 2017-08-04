//
//  WHFoodDetailCell.m
//  Meituan
//
//  Created by wh on 2017/8/4.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHFoodDetailCell.h"
#import "WHShopOrderFoodModel.h"

@interface WHFoodDetailCell ()<UIScrollViewDelegate>

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


/// scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/// 商品信息
@property (weak, nonatomic) IBOutlet UILabel *shopInfoLabel;

/// 商品评价的顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopCommentTopConstraint;

@end



@implementation WHFoodDetailCell

- (void)setFoodModel:(WHShopOrderFoodModel *)foodModel {
    _foodModel = foodModel;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:[foodModel.picture stringByDeletingPathExtension]]];
    
    _nameLabel.text = foodModel.name;
    
    _month_saled_contentLabel.text = foodModel.month_saled_content;
    
    _min_priceLabel.text = [@"¥ " stringByAppendingFormat:@"%@", @(foodModel.min_price)];
    
    _descLabel.text = foodModel.desc;
    
    
    CGFloat percentage = 0;
    // 计算好评率
    if (foodModel.praise_num) { //有点赞再去计算
        
        percentage = foodModel.praise_num / (foodModel.praise_num + foodModel.tread_num);
    }
    
    _percentageLabel.text = [NSString stringWithFormat:@"%.f%%", percentage * 100];
    
    // 设置进度
    _progressView.progress = percentage;
    
    
    // 是否有食物详情
    BOOL isDescContent = [foodModel.desc stringByReplacingOccurrencesOfString:@" " withString:@""].length;
    
    // 没有食物详情就隐藏商品信息label
    _shopInfoLabel.hidden = (isDescContent == NO);
    
    _shopCommentTopConstraint.constant = (isDescContent == YES) ? 8 : -24;
}



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
    
    _scrollView.delegate = self;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取垂直滚动位置
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 只有向下滚动'拖拽'才放大
    if (offsetY < 0) {
        
        CGFloat scale = [@(offsetY) resultWithValue1:HMValueMake(0, 1) andValue2:HMValueMake(-240, 2)];
        
        //        _pictureView.transform = CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformTranslate(transform, 0, offsetY * 0.5);
        
        transform = CGAffineTransformScale(transform, scale, scale);
        
        
        _pictureView.transform = transform;
        
    } else { // 防止猛拉猛推 缩不回去问题
        _pictureView.transform = CGAffineTransformIdentity;
    }
}


@end
