//
//  userTaskRewardToastView.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "userTaskRewardToastView.h"
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiGradeReWarReModel.h>
#import <LibProjModel/ApiGradeReListModel.h>
 
@interface userTaskRewardToastView ()
@property (nonatomic, copy)taskRewardDissmissBlock callBack;
@property (nonatomic, strong)ApiGradeReWarReModel *reward;
@property (nonatomic, assign)BOOL isAnchor;
@end
@implementation userTaskRewardToastView

+ (void)showTaskRewardToastOn:(UIView *)superView isAnchor:(BOOL)isAnchor  withReward:(ApiGradeReWarReModel*)reward callBack:(taskRewardDissmissBlock)callBack{
    CGFloat scale = 550/320.0;
    CGFloat width = 550 *kScreenWidth/750.0;
    CGFloat imageH = width/scale;
    NSInteger row = (reward.apiGradeReList.count-1)/3+1;
    CGFloat H = 110+row*60+imageH;
    userTaskRewardToastView *showView = [[userTaskRewardToastView alloc]initWithFrame:CGRectMake(0, 0 , width, H)];
    showView.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    showView.reward = reward;
    showView.isAnchor = isAnchor;
    showView.callBack = callBack;
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO cover:YES];

    [showView creatUI];
}
- (void)creatUI{
    CGFloat scale = 550/320.0;
    CGFloat width = 550 *kScreenWidth/750.0;
    CGFloat imageH = width/scale;
    NSInteger num = (self.reward.apiGradeReList.count-1)/3+1;
    CGFloat H = 110+num*60+imageH;
    
    UIImageView *headeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, imageH)];
    headeImageV.image = [UIImage imageNamed:@"mine_usertask_gift_toast_header"];
    headeImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:headeImageV];
    
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(25, imageH-20, width-30, 20)];
    tipL.textColor = kRGB_COLOR(@"#333333");
    tipL.textAlignment = NSTextAlignmentLeft;
    tipL.font = [UIFont systemFontOfSize:13];
    tipL.text = [NSString stringWithFormat:kLocalizationMsg(@"达到LV%d，您可获得以下礼物"),self.reward.nextGiftPackLevel];
    [headeImageV addSubview:tipL];
    
    UIView *bottmoV = [[UIView alloc]initWithFrame:CGRectMake(0, headeImageV.maxY, width,H-imageH)];
    bottmoV.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottmoV];
    
     
    CGFloat itemW = (width-40)/3.0;
    CGFloat item_margin = (itemW-30)/2.0;
    UIView *giftBackV = [[UIView alloc]initWithFrame:CGRectMake(20, 15, width-40, 10+num*60)];
    giftBackV.backgroundColor = [UIColor clearColor];
    giftBackV.layer.cornerRadius = 8;
    giftBackV.clipsToBounds = YES;
    giftBackV.layer.borderWidth = 0.8;
    giftBackV.layer.borderColor = kRGB_COLOR(@"#EEEEEE").CGColor;
    [bottmoV addSubview:giftBackV];
    for (int i = 0; i < self.reward.apiGradeReList.count; i++) {
        ApiGradeReListModel *model = self.reward.apiGradeReList[i];
        int row = i/3;
        int col = i%3;
        UIImageView *giftV = [[UIImageView alloc]initWithFrame:CGRectMake(item_margin+col*itemW, 10+60*row, 30, 30)];
        NSString *name;
        if (model.type == 1) {//金币
            name = [NSString stringWithFormat:@"%@x%d",kUnitStr,model.number];
            giftV.image = [ProjConfig getCoinImage];
        }else if(model.type == 2){//坐骑
            [giftV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            name = [NSString stringWithFormat:kLocalizationMsg(@"%@x%d天"),model.title,model.number];
        }else if(model.type == 3){//礼物
            name = [NSString stringWithFormat:kLocalizationMsg(@"%@x%d个"),model.title,model.number];
            [giftV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        }else {// 短视频
            name = [NSString stringWithFormat:kLocalizationMsg(@"%@x%d次"),model.title,model.number];
            giftV.image = [UIImage imageNamed:@"icon_account_reward_shortV"];
        }
        giftV.contentMode = UIViewContentModeScaleAspectFit;
        [giftBackV addSubview:giftV];
        UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, giftV.maxY, itemW, 20)];
        nameL.centerX = giftV.centerX;
        nameL.textColor = kRGB_COLOR(@"#666666");
        nameL.font = [UIFont systemFontOfSize:10];
        nameL.text = name;
        nameL.textAlignment = NSTextAlignmentCenter;
        [giftBackV addSubview:nameL];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, bottmoV.height-62, 150, 32)];
        sureBtn.layer.cornerRadius = 16;
        sureBtn.centerX = width/2.0;
        sureBtn.clipsToBounds = YES;
        sureBtn.backgroundColor =  self.isAnchor?kRGB_COLOR(@"#FDAE5E"):[ProjConfig normalColors];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setTitle:kLocalizationMsg(@"我知道了") forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [bottmoV addSubview:sureBtn];
    }
}
- (void)sureBtnClick:(UIButton *)btn{
    [[PopupTool share] closePopupView:self];
    self.callBack(YES);
}
@end
