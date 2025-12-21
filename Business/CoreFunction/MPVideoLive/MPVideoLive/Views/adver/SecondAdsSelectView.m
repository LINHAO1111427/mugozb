//
//  SecondAdsSelectView.m
//  MPVideoLive
//
//  Created by klc_sl on 2021/6/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SecondAdsSelectView.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/LiveRoomAdsModel.h>
#import "LiveAdverShowView.h"

@implementation SecondAdsSelectView

+ (void)showSecondLevelAdver:(NSArray<LiveRoomAdsModel *> *)adlist{
    if (adlist.count >0) {
        SecondAdsSelectView *showV = [[SecondAdsSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        showV.backgroundColor = kRGBA_COLOR(@"222222", 0.6);
        showV.adList = adlist;
        [showV createUI:adlist];
    }
}

- (void)createUI:(NSArray *)adList{

    CGFloat maxY = 0;
    CGFloat viewW = (kScreenWidth-(5*20))/4.0;
    CGFloat viewH = viewW+30;
    for (int i = 0; i < adList.count; i++) {
        LiveRoomAdsModel *adModel = self.adList[i];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(20+ (viewW+20)*(i%4), 40+(viewH+10)*(i/4), viewW, viewW+30);
        btn.tag = 77898+i;
        [btn addTarget:self action:@selector(adBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        maxY = btn.maxY;
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.width, btn.width)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4.0;
        [imgV sd_setImageWithURL:[NSURL URLWithString:adModel.adsImage]];
        [btn addSubview:imgV];
        
        UILabel *titleL = [[UILabel alloc] init];
        [btn addSubview:titleL];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textColor = [UIColor whiteColor];
        titleL.text = adModel.adsTitle;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgV.mas_bottom).offset(7);
            make.centerX.equalTo(imgV);
            make.width.mas_lessThanOrEqualTo(btn.width+20);
        }];
    }
    self.height = maxY+20+kSafeAreaBottom;
    [FunctionSheetBaseView showView:self cover:NO];
}




- (void)adBtnClick:(UIButton *)btn{
    LiveRoomAdsModel *adModel = self.adList[btn.tag - 77898];
    ///广告跳转类型 1:外部链接 2：app内链接 3：二级广告
    switch (adModel.adsJumpType) {
        case 1:
        {
            if (adModel.adsUrl) {
                if (kiOS(10)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:adModel.adsUrl] options:@{} completionHandler:nil];
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:adModel.adsUrl]];
                }
            }
        }
            break;
        case 2:
        {
            if (adModel.adsUrl) {
                [LiveAdverShowView showUrl:adModel.adsUrl];
            }
        }
            break;
        case 3:
        {
        }
            break;
        default:
            break;
    }
}


@end
