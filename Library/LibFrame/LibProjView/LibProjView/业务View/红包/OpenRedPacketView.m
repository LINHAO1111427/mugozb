//
//  OpenRedPacketView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OpenRedPacketView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/PopupTool.h>
#import "OpenRedPacketResultView.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/OneRedPacketVOModel.h>
#import <LibProjModel/HttpApiRedPacketController.h>

@interface OpenRedPacketView ()

@property (nonatomic, weak)UIView *openRedPacketV;

@property (nonatomic, weak)OpenRedPacketResultView *resultV;

@property (nonatomic, assign)int64_t currentRedPacketId;

@property (nonatomic, assign)int openType;

@property (nonatomic, copy)void (^_Nullable openRedPtHandle)(int);

@end

@implementation OpenRedPacketView

+ (void)showRedPicket:(OneRedPacketVOModel *)voModel openType:(int)openType openHandle:(void (^ _Nullable)(int))openHandle{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    if (!selfV) {
        OpenRedPacketView *redPacket = [[OpenRedPacketView alloc] init];
        redPacket.openType = openType;
        redPacket.openRedPtHandle = openHandle;
        [redPacket showOpenRedPacket:voModel];
    }
}

- (void)showOpenRedPacket:(OneRedPacketVOModel *)voModel{
    
    _currentRedPacketId = voModel.redPacketId;
    
    CGFloat viewW = kScreenWidth-100;
    self.frame = CGRectMake(0, 0, viewW, viewW*(375/275.0));
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 25;
    
    ///红包背景图片
    UIImageView *redPacketV = [[UIImageView alloc] initWithFrame:self.bounds];
    redPacketV.userInteractionEnabled = YES;
    redPacketV.image = [UIImage imageNamed:@"redpacket_big_envelope"];
    [self addSubview:redPacketV];
    _openRedPacketV = redPacketV;
    
    ///开红包按钮
    UIButton *openBtn = [UIButton buttonWithType:0];
    openBtn.frame = CGRectMake(0, 109.0/375.0*self.height, 90, 88);
    openBtn.centerX = redPacketV.centerX;
    [openBtn setBackgroundImage:[UIImage imageNamed:@"redpacket_open"] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [redPacketV addSubview:openBtn];
    
    ///关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(self.width-30-7, 7, 30, 30);
    closeBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [closeBtn setImage:[UIImage imageNamed:@"redpacket_close_yellow"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    ///红发发送人信息
    UIView *centerHeaderV = [[UIView alloc] init];
    [redPacketV addSubview:centerHeaderV];
    
    UIImageView *userIconV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    userIconV.layer.masksToBounds = YES;
    userIconV.layer.cornerRadius = 10;
    [userIconV sd_setImageWithURL:[NSURL URLWithString:voModel.sendUserAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    [centerHeaderV addSubview:userIconV];
    
    UILabel *userNameL = [[UILabel alloc] init];
    userNameL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@的红包"),voModel.sendUserName];
    userNameL.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    userNameL.textColor= kRGBA_COLOR(@"#FFE384", 1.0);
    [centerHeaderV addSubview:userNameL];
    
    ///显示红包总金币价值
    UILabel *coinText = [[UILabel alloc] init];
    coinText.text = [NSString stringWithFormat:kLocalizationMsg(@"价值%0.2lf%@"),voModel.deductionAfterTotalValue,[KLCAppConfig unitStr]];
    coinText.font = [UIFont systemFontOfSize:13];
    coinText.textColor= kRGBA_COLOR(@"#FFE384", 1.0);
    [redPacketV addSubview:coinText];
    
    [centerHeaderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redPacketV).mas_offset(25);
        make.centerX.equalTo(redPacketV);
    }];
    [userIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.top.bottom.equalTo(centerHeaderV);
    }];
    [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userIconV.mas_right).mas_offset(10);
        make.right.equalTo(centerHeaderV);
        make.centerY.equalTo(userIconV);
    }];
    [coinText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(redPacketV);
        make.bottom.equalTo(redPacketV).offset(-25);
    }];
    
    [self showView];
}


///关闭红包
- (void)closeBtnClick:(UIButton *)btn{
    [self dismissView];
}


///开红包
- (void)openBtnClick:(UIButton *)btn{
    if (_currentRedPacketId > 0) {
        btn.userInteractionEnabled = NO;
        kWeakSelf(self);
        [HttpApiRedPacketController openRedPacket:self.openType redPacketId:_currentRedPacketId callback:^(int code, NSString *strMsg, RedPacketVOModel *model) {
            btn.userInteractionEnabled = YES;
            if (code == 1) {
                weakself.openRedPtHandle?weakself.openRedPtHandle(model.isReceive):nil;
                [weakself.resultV showResult:model];
                [weakself.openRedPacketV removeFromSuperview];
            }else if (code == 10){
                [weakself dismissView];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg]; 
            }
        }];
    }
}



- (void)showView{
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES cover:YES];
    self.center = CGPointMake(self.superview.width/2.0, self.superview.height/2.0);
}


- (void)dismissView{
    [[PopupTool share] closePopupView:self];
}


- (OpenRedPacketResultView *)resultV{
    if (!_resultV) {
        OpenRedPacketResultView *resultV = [[OpenRedPacketResultView alloc] initWithFrame:self.bounds];
        [self addSubview:resultV];
        _resultV = resultV;
        [self sendSubviewToBack:resultV];
    }
    return _resultV;
}


@end
