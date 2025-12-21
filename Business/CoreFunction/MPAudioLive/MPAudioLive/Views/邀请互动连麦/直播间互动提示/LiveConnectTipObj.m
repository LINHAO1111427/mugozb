//
//  LiveConnectTipObj.m
//  LiveCommon
//
//  Created by yww on 2020/9/1.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveConnectTipObj.h"

#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveInfomation.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LiveMacros.h>


@interface LiveConnectTipView : UIView
@property (nonatomic, strong)UIButton *liveConnectBtn;
@end

@implementation LiveConnectTipView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    UIButton *liveConnectBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    [liveConnectBtn setBackgroundImage:[UIImage imageNamed:@"live_audio_connect_tip"] forState:UIControlStateNormal];
    [liveConnectBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"0人正在申请连麦")] forState:UIControlStateNormal];
    [liveConnectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    liveConnectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    liveConnectBtn.titleEdgeInsets = UIEdgeInsetsMake(7, 0, 13, 0);
    [self addSubview:liveConnectBtn];
    self.liveConnectBtn = liveConnectBtn;
}
 
@end



@interface LiveConnectTipObj()

@property (nonatomic, weak)UIView *superV;
@property (nonatomic, weak)LiveConnectTipView *tipView;
@property (nonatomic, assign)CGFloat rightSpace; ///距右侧的距离

@end
@implementation LiveConnectTipObj

- (void)dealloc
{
    [_tipView removeFromSuperview];
    _tipView = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView{
    self = [super init];
    if (self) {
        _superV = superView;
    }
    return self;
}
 
- (void)updatePointRightSpace:(CGFloat)rightSpace{
    _rightSpace = rightSpace;
    if (self.tipView) {
        self.tipView.x = kScreenWidth - (_tipView.width/2.0) - self.rightSpace;
    }    
}


- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rc = self.tipView.frame;
       self.tipView.liveConnectBtn.frame = CGRectMake(0, 0, 140, rc.size.height);
    } completion:nil];
}
- (void)dismiss{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = self.tipView.frame;
        self.tipView.liveConnectBtn.frame = CGRectMake(70, 0, 0, rc.size.height);
    } completion:^(BOOL finished) {
        [weakself.tipView removeAllSubViews];
        [weakself.tipView removeFromSuperview];
        weakself.tipView = nil;
    }];
}

- (void)liveConnectBtnClick:(UIButton *)btn{
    [LiveComponentMsgMgr sendMsg:LM_UI_applyOnlineList msgDic:nil];
    [self updateLiveConnectNumber:0];
    [self dismiss];
}

- (void)updateLiveConnectNumber:(int)number{
    if (number > 0) {
        [self show];
        [self.tipView.liveConnectBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"%d人正在申请连麦"),number] forState:UIControlStateNormal];
    }else{
        [self dismiss];
    }
}

- (LiveConnectTipView *)tipView{
    if (!_tipView) {
        LiveConnectTipView *tipView = [[LiveConnectTipView alloc] initWithFrame:CGRectMake(kScreenWidth-5*40+15-70, _superV.height-liveBottomViewH-40, 140, 40)];
        [_superV addSubview:tipView];
        tipView.backgroundColor = [UIColor clearColor];
        [tipView.liveConnectBtn addTarget:self action:@selector(liveConnectBtnClick:) forControlEvents:UIControlEventTouchUpInside];;
        _tipView = tipView;
    }
    _tipView.x = kScreenWidth - (_tipView.width/2.0) - self.rightSpace;
    return _tipView;
}


@end
