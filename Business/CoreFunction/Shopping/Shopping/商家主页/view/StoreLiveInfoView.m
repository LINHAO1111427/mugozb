//
//  StoreLiveInfoView.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreLiveInfoView.h"
#import <LibProjModel/ShopLiveGoodsModel.h>
#import <LibProjView/CheckRoomPermissions.h>

@interface StoreLiveInfoView ()

@property (nonatomic, strong)UIImageView *liveThumbImageV;
@property (nonatomic, strong)UIScrollView *imaesScroll;
@property (nonatomic, strong)UILabel *liveStatusL;//状态栏
@property (nonatomic, strong)UILabel *liveTitleL;//标题
@property (nonatomic, strong)UIButton *watchBtn;//观看
@property (nonatomic, strong)UILabel *liveAudienceL;//观众

@end

@implementation StoreLiveInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    _liveThumbImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 15, self.height-30, self.height-30)];
    _liveThumbImageV.layer.masksToBounds = YES;
    _liveThumbImageV.layer.cornerRadius = 3;
    _liveThumbImageV.backgroundColor = [UIColor lightGrayColor];
    [_liveThumbImageV addSubview:self.liveStatusL];
    [self addSubview:_liveThumbImageV];
    
    
    _liveTitleL = [[UILabel alloc]initWithFrame:CGRectMake(_liveThumbImageV.maxX+10, _liveThumbImageV.y, self.width-_liveThumbImageV.width-24, 20)];
    _liveTitleL.textColor = kRGB_COLOR(@"#2B2C2C");
    _liveTitleL.font = [UIFont boldSystemFontOfSize:15];
    _liveTitleL.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_liveTitleL];
    
    
    _liveAudienceL = [[UILabel alloc]initWithFrame:CGRectMake(_liveTitleL.x, _liveTitleL.maxY+10, _liveTitleL.width-75, 20)];
    _liveAudienceL.textColor = kRGB_COLOR(@"#333333");
    _liveAudienceL.font = [UIFont systemFontOfSize:13];
    _liveAudienceL.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_liveAudienceL];
    
    
    CGFloat scrollH = _liveThumbImageV.height/2.0;
    _imaesScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(_liveThumbImageV.maxX+10, _liveThumbImageV.maxY-scrollH, self.width-12-_liveThumbImageV.maxX-10, scrollH)];
    [self addSubview:_imaesScroll];
    
    
    _watchBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-82, 0, 70, 28)];
    _watchBtn.centerY = _liveAudienceL.centerY;
    [_watchBtn setTitle:kLocalizationMsg(@"立即观看") forState:UIControlStateNormal];
    _watchBtn.layer.cornerRadius = 14;
    _watchBtn.clipsToBounds = YES;
    _watchBtn.backgroundColor =kRGB_COLOR(@"#FF5500");
    _watchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_watchBtn addTarget:self action:@selector(watchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_watchBtn];
    
}

- (void)watchBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字立即观看直播购"));
    [[CheckRoomPermissions share] joinRoom:self.liveRoomId liveDataType:LiveTypeForMPVideo joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
        [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:nil];
    } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
        [[CheckRoomPermissions share] showDetail:dtoModel currentVC:[ProjConfig currentVC]];
    } fail:nil];
}


#pragma mark - lazy load
- (UILabel *)liveStatusL{
    
    if (!_liveStatusL) {
        _liveStatusL = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, 52, 25)];
        _liveStatusL.layer.cornerRadius = 12.5;
        _liveStatusL.clipsToBounds = YES;
        _liveStatusL.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *att  = [[NSMutableAttributedString alloc]initWithString:kLocalizationMsg(@" 直播中")];
        UIView *point = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
        point.layer.cornerRadius = 2;
        point.clipsToBounds = YES;
        point.backgroundColor = [UIColor whiteColor];
        UIImage *image = [UIImage imageConvertFromView:point];
        NSTextAttachment *attach = [[NSTextAttachment alloc]init];
        attach.image = image;
        attach.bounds = CGRectMake(0, 1, 4, 4);
        NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:attach];
        [att insertAttributedString:imageAtt atIndex:0];
        _liveStatusL.attributedText = att;
        _liveStatusL.textColor= [UIColor whiteColor];
        _liveStatusL.backgroundColor = kRGB_COLOR(@"#FF8503");
        _liveStatusL.font = [UIFont systemFontOfSize:10];
    }
    return _liveStatusL;

}



///显示直播的信息
- (void)setLiveDetailDTO:(ShopLiveDetailDTOModel *)liveDetailDTO{
    _liveDetailDTO = liveDetailDTO;
    
    [self.liveThumbImageV sd_setImageWithURL:[NSURL URLWithString:liveDetailDTO.thumb]];
    self.liveTitleL.text = liveDetailDTO.title;
    self.liveAudienceL.text = kStringFormat(kLocalizationMsg(@"%d人正在观看"),liveDetailDTO.liveUsers);
    
    [self.imaesScroll removeAllSubViews];
    
    CGFloat maxX = 0;
    for (ShopLiveGoodsModel *goods in liveDetailDTO.liveGoodsList) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(maxX+(maxX?10:0), 0, self.imaesScroll.height, self.imaesScroll.height)];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds = YES;
        imgV.layer.cornerRadius = 5;
        NSArray *itemArr = [goods.goodsPicture componentsSeparatedByString:@","];
        NSString *picUrl = itemArr.count>0?itemArr.firstObject:@"";
        [imgV sd_setImageWithURL:[NSURL URLWithString:picUrl]];
        [self.imaesScroll addSubview:imgV];
        maxX = imgV.maxX;
    }
    self.imaesScroll.contentSize = CGSizeMake(maxX, 0);
    
}

@end
