//
//  WHShopHeaderView.m
//  Meituan
//
//  Created by wh on 2017/8/1.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopHeaderView.h"
#import "WHShopPOI_InfoModel.h"
#import "WHInfoLoopView.h"
#import "WHShopDetailController.h"
#import "WHShopDetailAnimator.h"


@interface WHShopHeaderView ()
/// 背景imageView
@property (nonatomic, weak) UIImageView *backImageView;
/// 头像
@property (nonatomic, weak) UIImageView *avatarView;

/// 店名
@property (nonatomic, weak) UILabel *nameLabel;

/// 商家公告
@property (nonatomic, weak) UILabel *bulletinLabel;

/// 优惠信息轮播视图
@property (nonatomic, weak) WHInfoLoopView *loopView;

/// 此属性是为了强引用住转场动画代码对象
@property (nonatomic, strong) WHShopDetailAnimator *animator;
@end
@implementation WHShopHeaderView

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
    
    // 1.添加背景图片
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self addSubview:backImageView];
    
    // 设置填充模式
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    
    // 2.轮播视图
    WHInfoLoopView *loopView = [[WHInfoLoopView alloc] init];
    loopView.clipsToBounds = YES; // 把子控件超出的区域裁剪
    [self addSubview:loopView];
    
    [loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-8);
        make.height.offset(20);
    }];
    // 2.1 添加轮播视图右边的小箭头
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_white"]];
    [loopView addSubview:arrowView];
    
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.centerY.offset(0);
    }];
    
    
    
    // 3.虚线
    UIView *dashLineView = [[UIView alloc] init];
 dashLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashLineViewWithColor:[UIColor whiteColor]]];
    
    [self addSubview:dashLineView];
    
    [dashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loopView).offset(0);
        make.right.offset(0);
        make.bottom.equalTo(loopView.mas_top).offset(-8);
        make.height.offset(1);
    }];
    
    
    // 4.头像
    UIImageView *avatarView = [[UIImageView alloc] init];
    avatarView.backgroundColor = [UIColor blueColor];
    [self addSubview:avatarView];
    // 设置圆角
    avatarView.layer.cornerRadius = 32;
    // 超出边界的裁剪掉
    avatarView.clipsToBounds = YES;
    
    // 设置边框颜色
    avatarView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
    // 边框宽度
    avatarView.layer.borderWidth = 2;
    
    // 添充模式
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dashLineView).offset(0);
        make.bottom.equalTo(dashLineView.mas_top).offset(-8);
        make.width.height.offset(64);
    }];
    
    
    
    // 5.店名
    UILabel *nameLabel = [UILabel makeLabelWithText:@"粮新发现(修正店)" andTextFont:16 andTextColor:[UIColor whiteColor]];
    [self addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarView.mas_right).offset(16);
        make.centerY.equalTo(avatarView).offset(-16);
    }];
    
    
    // 6.商家公告
    UILabel *bulletinLabel = [UILabel makeLabelWithText:@"公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告" andTextFont:14 andTextColor:[UIColor colorWithWhite:1 alpha:0.9]];
    [self addSubview:bulletinLabel];
    
    [bulletinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(0);
        make.centerY.equalTo(avatarView).offset(16);
        make.right.offset(-16);
    }];
    
    
    _backImageView = backImageView;
    _avatarView = avatarView;
    _nameLabel = nameLabel;
    _bulletinLabel = bulletinLabel;
    _loopView = loopView;
    
    
    
    // TODO:给轮播视图添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopViewClick)];
    // 手势添加到loopView上
    [loopView addGestureRecognizer:tap];
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 一启就让它模态出商家详情控制器
//        [self loopViewClick];
//        
//    });
}


#pragma mark - 轮播视图点击手势调用的方法
- (void)loopViewClick {
    
    // 1.创建商家详情控制器
    WHShopDetailController *detailVC = [[WHShopDetailController alloc] init];
    
    // 给商家详情控制器传数据
    detailVC.shopPOIInfoModel = _shopPOI_infoModel;
    
    
    // 设置展示后后面控制器view的显示方式 展示样式为自定义
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    
    // 创建转场代理对象
    _animator = [[WHShopDetailAnimator alloc] init];
    
    // 给要显示'modal'出来的控制器设置转场代理
    detailVC.transitioningDelegate = _animator;

    
    // 2.模态商家详情控制器
    [self.viewControler presentViewController:detailVC animated:YES completion:nil];
    
}













#pragma mark - 有了数据之后给子控件设置数据
- (void)setShopPOI_infoModel:(WHShopPOI_InfoModel *)shopPOI_infoModel {
    _shopPOI_infoModel = shopPOI_infoModel;
    
    
    // 删除url后面多余的.webp后缀
    NSString *bgImageURLStr = [shopPOI_infoModel.poi_back_pic_url stringByDeletingPathExtension];
    
    
    // 设置背景图片
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:bgImageURLStr]];
    
    
    // 头像
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:[shopPOI_infoModel.pic_url stringByDeletingPathExtension]]];
    
    
    // 店名
    _nameLabel.text = shopPOI_infoModel.name;
    
    
    // 商家公告
    _bulletinLabel.text = shopPOI_infoModel.bulletin;

    
    // 把所有的优惠 信息模型数组传给轮播视图
    _loopView.discounts = shopPOI_infoModel.discounts;

    
}
@end

