//
//  UserGiftPackView.m
//  LibProjView
//
//  Created by klc on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import "UserGiftPackView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/GiftPackVOModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoLoginModel.h>
#import <LibProjBase/PopupTool.h>
#import <SDWebImage.h>

@interface UserGiftPackView ()
@property (nonatomic, copy)GiftPackCallback callBack;
@end

@implementation UserGiftPackView

///新手大礼包
+ (void)showGiftPackCallBack:(GiftPackCallback)callBack{
    
    if ([KLCUserInfo packList].count > 0 && [KLCUserInfo isFirstLogin]) {
        [UserGiftPackView showGiftPackNowWithGifts:[KLCUserInfo packList] callBack:callBack];
    }else{
        if (callBack) {
            callBack(NO);
        }
    }
}


+ (void)showGiftPackNowWithGifts:(NSArray *)gifts callBack:(GiftPackCallback)callBack{
    UserGiftPackView *showView = [[UserGiftPackView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    showView.callBack = callBack;
    CGFloat width = 272.0*kScreenWidth/360;
    CGFloat height = width*372/272.0;
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tipView.backgroundColor = kRGB_COLOR(@"#FFF1D7");
    tipView.layer.cornerRadius = 8;
    tipView.center = showView.center;
    tipView.clipsToBounds = YES;
    [showView addSubview:tipView];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopupTool bringViewToFront:[UserGiftPackView class]];
    });
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tipView.maxY+20, 40, 40)];
    closeBtn.centerX = tipView.centerX;
    [closeBtn setImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:showView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.backgroundColor = [UIColor clearColor];
    [showView addSubview:closeBtn];
  
    CGFloat scaleT = 182/30.0;
    CGFloat widthT = 180.0*kScreenWidth/360;
    CGFloat heightT = widthT/scaleT;
    UIImageView *tipTextipImageV = [[UIImageView alloc]initWithFrame:CGRectMake((width-widthT)/2.0, 20, widthT, heightT)];
    tipTextipImageV.image = [UIImage imageNamed:@"system_tip_gift_text"];
    [tipView addSubview:tipTextipImageV];
    
    CGFloat scaleGI = 1.0;
    CGFloat widthGI= 110.0*kScreenWidth/360;
    CGFloat heightGI = widthGI/scaleGI;
    UIImageView *tipImageV = [[UIImageView alloc]initWithFrame:CGRectMake((width-widthGI)/2.0, tipTextipImageV.maxY+15, widthGI, heightGI)];
    tipImageV.image = [UIImage imageNamed:@"system_tip_gift"];
    [tipView addSubview:tipImageV];
    
    //小礼物
    CGFloat magin = 12*kScreenWidth/360.0;;
    CGFloat widthG= (width-4*magin)/3.0;
    for (int i = 0; i < gifts.count; i++) {
        GiftPackVOModel *model = gifts[i];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(magin+(widthG+magin)*i, tipImageV.maxY+20, widthG, widthG)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 5;
        [tipView addSubview:bgView];
        
        UIImageView *giftImageV = [[UIImageView alloc] init];
        giftImageV.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:giftImageV];
        [giftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(bgView).inset(15);
        }];
        if ([model.action isEqualToString: @"coin"]) {
            giftImageV.contentMode = UIViewContentModeScaleAspectFit;
            giftImageV.image = [ProjConfig getCoinImage];
        }else{
             [giftImageV sd_setImageWithURL:[NSURL URLWithString:model.gifticon] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView.maxY+5, widthG, 20)];
        titleLabel.centerX = bgView.centerX;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = kRGB_COLOR(@"#373737");
        if ([model.action isEqualToString: @"coin"]) {
             titleLabel.text = [NSString stringWithFormat:@"+%d%@",model.typeVal,model.name];
        }else if([model.action isEqualToString: @"gift"]){
            titleLabel.text = [NSString stringWithFormat:@"%@x%d",model.name,model.typeVal];
        }else if([model.action isEqualToString: @"car"]){
            titleLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@(%d天)"),model.name,model.typeVal];
        }else{
            titleLabel.text = model.name;
        }
        [tipView addSubview:titleLabel];
    }
    
    //知道了按钮
    UIButton *kownBtn  = [[UIButton alloc]initWithFrame:CGRectMake((width-160)/2.0, height-60, 160, 40)];
    kownBtn.layer.cornerRadius = 20;
    kownBtn.clipsToBounds = YES;
    kownBtn.backgroundColor = kRGB_COLOR(@"#F54314");
    [kownBtn addTarget:showView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [kownBtn setTitle:kLocalizationMsg(@"我知道了") forState:UIControlStateNormal];
    [kownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    kownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [tipView addSubview:kownBtn];
}

- (void)closeBtnClick:(UIButton *)btn{
    [KLCUserInfo removePackList];
    self.callBack(YES);
    [self removeAllSubViews];
    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
}
 
@end
