//
//  LiveAdvertisingView.m
//  MPVideoLive
//
//  Created by klc_sl on 2021/6/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "LiveAdvertisingView.h"
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/LiveRoomAdsModel.h>
#import "LiveAdverShowView.h"
#import "SecondAdsSelectView.h"

@interface LiveAdvertisingView ()

@property (nonatomic, strong)LiveRoomAdsModel *adsModel; ///一级广告
@property (nonatomic, copy)NSArray<LiveRoomAdsModel *> *twoLiveRoomAdsList; ///二级广告

@end

@implementation LiveAdvertisingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAdData];
    }
    return self;
}

- (void)createUI{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = self.bounds;
    [btn addTarget:self action:@selector(adBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.width, btn.width)];
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = 4.0;
    [imgV sd_setImageWithURL:[NSURL URLWithString:self.adsModel.adsImage]];
    [btn addSubview:imgV];
    
    UIButton *btnTitleL = [UIButton buttonWithType:0];
    btnTitleL.userInteractionEnabled = NO;
    [btn addSubview:btnTitleL];
    btnTitleL.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btnTitleL setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2]];
    [btnTitleL setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btnTitleL setTitle:self.adsModel.adsTitle forState:UIControlStateNormal];
    [btnTitleL setContentEdgeInsets:UIEdgeInsetsMake(0, 9, 0, 9)];
    [btnTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgV.mas_bottom).offset(7);
        make.centerX.equalTo(imgV);
        make.height.mas_equalTo(22);
        make.width.mas_lessThanOrEqualTo(btn.width+30);
    }];
    [btnTitleL layoutIfNeeded];
    btnTitleL.layer.masksToBounds = YES;
    btnTitleL.layer.cornerRadius = 9.0;
}


- (void)loadAdData{
    ///请求网络接口
    kWeakSelf(self);
    [HttpApiPublicLive getLiveRoomAdsList:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, LiveRoomAdsListVOModel *model) {
        ///接口请求成功，并且一级广告有数据
        weakself.adsModel = model.liveRoomAds;
        weakself.twoLiveRoomAdsList = model.twoLiveRoomAdsList;
        if (code == 1 && weakself.adsModel.id_field > 0) {
            [weakself createUI];
        }
    }];
}


- (void)adBtnClick:(UIButton *)btn{
    ///广告跳转类型 1:外部链接 2：app内链接 3：二级广告
    switch (self.adsModel.adsJumpType) {
        case 1:
        {
            if (self.adsModel.adsUrl) {
                if (kiOS(10)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.adsModel.adsUrl] options:@{} completionHandler:nil];
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.adsModel.adsUrl]];
                }
            }
        }
            break;
        case 2:
        {
            if (self.adsModel.adsUrl) {
                [LiveAdverShowView showUrl:self.adsModel.adsUrl];
            }
        }
            break;
        case 3:
        {
            [SecondAdsSelectView showSecondLevelAdver:self.twoLiveRoomAdsList];
        }
            break;
        default:
            break;
    }
}


@end



