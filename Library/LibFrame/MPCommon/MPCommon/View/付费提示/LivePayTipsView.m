//
//  LivePayTipsView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/11/5.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LivePayTipsView.h"
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/ProjConfig.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjView/BalanceLackPromptView.h>
#import <LibProjModel/ApiExitRoomModel.h>
#import <LiveCommon/LiveTimekeeping.h>

@interface LivePayTipsView ()

@property (nonatomic, assign)int chargeType; ///收费类型  ///0:无   1:改变房间模式  2:试看完成

@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, weak)UIImageView *stateImg;
@property (nonatomic, weak)UILabel *detailLab;
@property (nonatomic, weak)UILabel *conditionLab;
@property (nonatomic, weak)UIButton *cancelBtn;
@property (nonatomic, weak)UIButton *sureBtn;

@property (nonatomic, weak)UIView *superView;

@end

@implementation LivePayTipsView


- (instancetype)initWithSuperView:(UIView *)superV{
    self = [super init];
    if (self) {
        _superView = superV;
        [superV addSubview:self];
        [superV sendSubviewToBack:self];
        
        [LiveManager promissionStop:YES];

        [self createView];
    }
    return self;
}

- (void)createView{
    ///本视图
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
    self.backgroundColor = [UIColor whiteColor];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(275, 255));
        make.center.equalTo(self.superview);
    }];

    
    ///标题文字
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = kRGBA_COLOR(@"#333333", 1.0);
    titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleL];
    _titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(10);
        make.top.equalTo(self).inset(15);
        make.height.mas_equalTo(21);
    }];
    
    ///状态图片
    UIImageView *stateImg = [[UIImageView alloc] init];
    stateImg.image = [UIImage imageNamed:@"icon_payment_tips"];
    stateImg.centerX = self.width/2.0;
    [self addSubview:stateImg];
    _stateImg = stateImg;
    [stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 110));
        make.centerX.equalTo(self);
        make.top.equalTo(titleL.mas_bottom).inset(10);
    }];

    ///详细文字
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.font = [UIFont systemFontOfSize:13];
    detailLab.textColor = kRGBA_COLOR(@"#999999", 1.0);
    detailLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detailLab];
    _detailLab = detailLab;
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(10);
        make.top.equalTo(stateImg.mas_bottom).inset(5);
        make.height.mas_equalTo(20);
    }];
    
    ///开通条件
    UILabel *conditionLab = [[UILabel alloc] init];
    conditionLab.font = [UIFont systemFontOfSize:13];
    conditionLab.textColor = kRGBA_COLOR(@"#333333", 1.0);
    conditionLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:conditionLab];
    _conditionLab = conditionLab;
    [conditionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(detailLab.mas_bottom).inset(5);
    }];

    ///取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    cancelBtn.backgroundColor = kRGBA_COLOR(@"#EEEEEE", 1.0);
    [cancelBtn setTitle:kLocalizationMsg(@"下次在看") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelBtn setTitleColor:kRGBA_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 16.0;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 32));
        make.bottom.equalTo(self).inset(17);
        make.left.equalTo(self).inset(30);
    }];
    
    ///确认按钮
    UIButton *sureBtn = [UIButton buttonWithType:0];
    sureBtn.frame = CGRectMake(cancelBtn.maxX+15, cancelBtn.y, 100, 32);
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sureBtn setTitleColor:kRGBA_COLOR(@"#ffffff", 1.0) forState:UIControlStateNormal];
    [self addSubview:sureBtn];
    _sureBtn = sureBtn;
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 16.0;
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 32));
        make.right.equalTo(self).inset(30);
        make.centerY.equalTo(cancelBtn);
    }];
}

///取消付费
- (void)cancelClick{
    if (self.paymengBlock){
        self.paymengBlock(NO);
    }
    [LiveComponentMsgMgr sendMsg:LM_CloseLive msgDic:nil];
}

///点击确认按钮
- (void)sureBtnClick{
    kWeakSelf(self);
    [self livePayment:^(int code, NSString *strMsg) {
        if (code == 1) {
            [LiveManager promissionStop:NO];
            [weakself dismissView];
        }else if (code == 7101){  ///金额不足
            [BalanceLackPromptView gotoRecharge:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///确认付费
- (void)livePayment:(void(^)(int code, NSString *strMsg))block{
    kWeakSelf(self);
    AppJoinRoomVOModel *vcModel = [LiveManager liveInfo].roomModel;
    int64_t anchorId = vcModel.anchorId;
    int roomType = vcModel.roomType;
    int64_t roomId = vcModel.roomId;
    NSString *roomTypeVal = vcModel.roomTypeVal;
    int liveType = vcModel.liveType;
    NSString *showId = vcModel.showid;
    [HttpApiPublicLive startDeduction:anchorId liveType:liveType roomId:roomId roomType:roomType roomTypeVal:roomTypeVal showId:showId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (weakself.paymengBlock){
            weakself.paymengBlock((code == 1)?YES:NO);
        }
        if (block) {
            block(code, strMsg);
        }
    }];
}


///购买VIP
- (void)payVipClick{
    [LiveComponentMsgMgr sendMsg:LM_BuyVIP msgDic:nil];
}


///显示免费时长观看权限
- (void)showFeeTips{
    
    ///房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
    AppJoinRoomVOModel *vcModel = [LiveManager liveInfo].roomModel;
    switch (vcModel.roomType) {
        case 2:
        {
            [_sureBtn setTitle:kLocalizationMsg(@"付费观看") forState:UIControlStateNormal];
            _titleL.text = kLocalizationMsg(@"门票房间付费提示");
            
            NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"观看Ta直播需收门票 %@%@"),vcModel.roomTypeVal,[KLCAppConfig unitStr]];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showStr];
            [str addAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"333333", 1.0), NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(10, showStr.length-10)];
            _detailLab.attributedText = str;
            [self addSureBtnAction:@selector(sureBtnClick)];
        }
            break;
        case 3:
        {
            [_sureBtn setTitle:kLocalizationMsg(@"付费观看") forState:UIControlStateNormal];
            _titleL.text = kLocalizationMsg(@"计时房间付费提示");
            
            NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"观看Ta直播需收费 %@%@/分钟"),vcModel.roomTypeVal,[KLCAppConfig unitStr]];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showStr];
            [str addAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"333333", 1.0), NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(9, showStr.length-9)];
            _detailLab.attributedText = str;
            [self addSureBtnAction:@selector(sureBtnClick)];
        }
            break;
        case 4:
        {
            [_sureBtn setTitle:kLocalizationMsg(@"开通贵族") forState:UIControlStateNormal];
            _titleL.text = kLocalizationMsg(@"贵族房间提示");
            
            NSString *showStr = kLocalizationMsg(@"观看Ta直播需 开通贵族");
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showStr];
            [str addAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"333333", 1.0), NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(7, showStr.length-7)];
            _detailLab.attributedText = str;
            [self addSureBtnAction:@selector(payVipClick)];
        }
            break;
        default:
        {
            [LiveManager promissionStop:NO];
            [self dismissView];
        }
            break;
    }
}

- (void)addSureBtnAction:(SEL)selector{
    [_sureBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [_sureBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)showChangeTips:(ApiExitRoomModel *)roomModel{
    
    _titleL.text = kLocalizationMsg(@"房间模式更改提示");
    _detailLab.text = [NSString stringWithFormat:kLocalizationMsg(@"此房间更改为 %@"),roomModel.roomName];
    _detailLab.y -=5;
    _conditionLab.y -=5;
    
    ///房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
    [LiveManager liveInfo].roomModel.roomType = roomModel.roomType;
    [LiveManager liveInfo].roomModel.roomTypeVal = roomModel.roomTypeVal;

    switch (roomModel.roomType) {
        case 1:
        {
            
            [_sureBtn removeFromSuperview];
            [_cancelBtn setTitle:kLocalizationMsg(@"退出房间") forState:UIControlStateNormal];
            _cancelBtn.centerX = self.width/2.0;
            
            __block int totalTime = 4;
            kWeakSelf(self);
            [[LiveTimekeeping share] addTimerObserver:self timeBlock:^(int64_t currentTime) {
                @synchronized (weakself) {
                    --totalTime;
                    weakself.conditionLab.text = [NSString stringWithFormat:kLocalizationMsg(@"%ds后您将自动退出房间"),totalTime];
                    if (totalTime == 0) {
                        [[LiveTimekeeping share] removeTimerObserver:weakself];
                        [weakself cancelClick];
                    }
                }
            }];
        }
            break;
        case 2:
        {
            [_sureBtn setTitle:kLocalizationMsg(@"付费观看") forState:UIControlStateNormal];
            _conditionLab.text = [NSString stringWithFormat:@"%@%@",roomModel.roomTypeVal,[KLCAppConfig unitStr]];
            [self addSureBtnAction:@selector(sureBtnClick)];
        }
            break;
        case 3:
        {
            [_sureBtn setTitle:kLocalizationMsg(@"付费观看") forState:UIControlStateNormal];
            _conditionLab.text = [NSString stringWithFormat:kLocalizationMsg(@"%@%@/分钟"),roomModel.roomTypeVal,[KLCAppConfig unitStr]];
            [self addSureBtnAction:@selector(sureBtnClick)];
        }
            break;
        case 4:
        {
            [_sureBtn setTitle:kLocalizationMsg(@"开通贵族") forState:UIControlStateNormal];
            _conditionLab.text = kLocalizationMsg(@"开通贵族即可观看直播");
            [self addSureBtnAction:@selector(payVipClick)];
        }
            break;
        default:
        {
            [LiveManager promissionStop:NO];
            [self dismissView];
        }
            break;
    }
}




- (void)rechargeSuccess{
    kWeakSelf(self);
    [self livePayment:^(int code, NSString *strMsg) {
        if (code == 1) {
            [LiveManager promissionStop:NO];
            [weakself dismissView];
        }
    }];
}

- (void)dismissView{
    [LiveManager promissionStop:NO];
    [self removeFromSuperview];
}



@end
