//
//  HZBannerCell.m
//
//  Created by sssssssss on 2020/8/11.
//  Copyright © 2020 . All rights reserved.
//

#import "KLBannerCell.h"
#import <LibProjModel/ShopLiveAnnouncementDetailDTOModel.h>
#import <LibProjModel/HttpApiUserController.h>

@interface KLBannerCell ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UIImageView *leftUpImageV;
@property (nonatomic, strong)UILabel *leftUpL;
@property (nonatomic, strong)UIButton *attBtn;

@end

@implementation KLBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 10.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat imageViewHeight = self.bounds.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, self.bounds.size.width-12, imageViewHeight)];
    imageView.layer.cornerRadius = 10.0f;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = true;
    self.imageView = imageView;
    [self.contentView addSubview:self.imageView];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+12, self.height-30, self.width-60-30-12, 20)];
    textLabel.textColor = kRGB_COLOR(@"#FFFFFF");
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel = textLabel;
    [self.contentView addSubview:_textLabel];
    
    _leftUpL = [[UILabel alloc]initWithFrame:CGRectMake(12+10, 10, 140, 20)];
    _leftUpL.textAlignment = NSTextAlignmentCenter;
    _leftUpL.font = [UIFont systemFontOfSize:11];
    _leftUpL.textColor = [UIColor whiteColor];
    _leftUpL.backgroundColor = kRGBA_COLOR(@"#000000", 0.4);
    _leftUpL.layer.cornerRadius = 10;
    _leftUpL.clipsToBounds = YES;
    [self.contentView addSubview:_leftUpL];
    
    _leftUpImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12+10, 0, 20, 20)];
    _leftUpImageV.layer.cornerRadius = 10;
    _leftUpImageV.centerY = _leftUpL.centerY;
    _leftUpImageV.clipsToBounds = YES;
    _leftUpImageV.image = [UIImage imageNamed:@"shop_home_time"];
    [self.contentView addSubview:_leftUpImageV];
    
    _attBtn = [[UIButton alloc]initWithFrame:CGRectMake(_textLabel.maxX+10, 0, 60, 24)];
    _attBtn.centerY = _textLabel.centerY;
    [_attBtn setTitle:kLocalizationMsg(@"+ 关注") forState:UIControlStateNormal];
    [_attBtn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateSelected];
    _attBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_attBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_attBtn addTarget:self action:@selector(attBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _attBtn.layer.cornerRadius = 12;
    _attBtn.hidden = YES;
    _attBtn.clipsToBounds = YES;
    [_attBtn setBackgroundImage:[UIImage createImageSize:_attBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF8503"),kRGB_COLOR(@"#FF5E0D")] percentage:@[@0.2,@1.0] gradientType:GradientFromLeftTopToRightBottom] forState:UIControlStateNormal];
    [self.contentView addSubview:_attBtn];
}
- (void)attBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [HttpApiUserController setAtten:!self.model.isAttention touid:self.model.anchorId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.model.isAttention = !weakself.model.isAttention;
            weakself.attBtn.selected = weakself.model.isAttention;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)setModel:(ShopLiveAnnouncementDetailDTOModel *)model{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.posterStickers] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    _textLabel.text = model.title;
    _leftUpL.text = [NSString stringWithFormat:@"  %@",[model.startTime timeStringWithDateFormat:@"yyyy-MM-dd HH:mm"]];
    _attBtn.hidden = model.isAttention;
}
@end
