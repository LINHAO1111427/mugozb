//
//  LiveExitSelectView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveExitSelectView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>

@interface LiveExitSelectView ()

@property (nonatomic, copy)NSArray *funcArr;

@property (nonatomic, weak)UIView *funcBgView;

@end

@implementation LiveExitSelectView

+ (void)showExitFunctionSelectView{

    LiveExitSelectView *selectView = [[LiveExitSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [selectView createUI];
}

- (void)createUI{
    
    _funcArr = [self getFuncArr];
    if (_funcArr.count == 0) {  ///没有任何功能直接离开房间
        [self exitBtnClick];
        return;
    }
    
    CGFloat coverH = 309;
    UIView *coverView = [[UIView alloc] init];
    coverView.frame = CGRectMake(0, self.height-coverH, self.width, coverH);
    coverView.alpha = 0.96;
    // Background Code
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = coverView.bounds;
    gl.startPoint = CGPointMake(0.50, 0.00);
    gl.endPoint = CGPointMake(0.50, 1.00);
    gl.colors = @[
    (__bridge id)[UIColor colorWithRed:32/255.0 green:23/255.0 blue:32/255.0 alpha:0].CGColor,
    (__bridge id)[UIColor colorWithRed:32/255.0 green:23/255.0 blue:32/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:32/255.0 green:23/255.0 blue:32/255.0 alpha:1.0].CGColor,
    ];
    gl.locations = @[@(0),@(0.64f),@(1.0f)];
    [coverView.layer addSublayer:gl];
    [self addSubview:coverView];

    UIView *bgCenterView = [[UIView alloc] init];
    [self addSubview:bgCenterView];
    _funcBgView = bgCenterView;
    [bgCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(88);
        make.width.mas_equalTo(self.width-20);
        make.centerX.mas_equalTo(self);
        make.bottom.equalTo(self).mas_equalTo(-(30+kSafeAreaBottom));
    }];
    [bgCenterView layoutIfNeeded];

    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES];

    [self showFuncItem];
}

///显示功能按钮
- (void)showFuncItem{
    [_funcBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat itemW = 70;
    CGFloat itemH = _funcBgView.height;
    CGFloat space = (_funcBgView.width - _funcArr.count*itemW)/((_funcArr.count+1)*1.0);
    
    for (int i = 0; i< _funcArr.count; i++) {
        NSDictionary *subDic = _funcArr[i];
        UIButton *funcBtn = [UIButton buttonWithType:0];
        funcBtn.frame = CGRectMake(space+i*(itemW+space), 0, itemW, itemH);
        funcBtn.tag = 559983+i;
        [funcBtn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_funcBgView addSubview:funcBtn];
        
        NSString *showImgStr = subDic[@"imgName"];
        NSString *showTitle = subDic[@"title"];
        if ([subDic[@"funcId"] intValue] == 3) {
            showImgStr = [LiveManager liveInfo].roomModel.liveLockStatus?subDic[@"selectImg"]:subDic[@"imgName"];
            showTitle = [LiveManager liveInfo].roomModel.liveLockStatus?kLocalizationMsg(@"房间解锁"):subDic[@"title"];
        }
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemW, itemW)];
        imgV.image = [UIImage imageNamed:showImgStr];
        [funcBtn addSubview:imgV];
        
        UILabel *textL = [[UILabel alloc] init];
        textL.text = showTitle;
        textL.textColor = [UIColor whiteColor];
        textL.font = [UIFont systemFontOfSize:13];
        [funcBtn addSubview:textL];
        [textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(funcBtn);
            make.bottom.equalTo(funcBtn);
            make.height.mas_equalTo(19);
        }];
    }
}


- (void)funcBtnClick:(UIButton *)btn{
    NSDictionary *subDic = _funcArr[btn.tag-559983];
    switch ([subDic[@"funcId"] intValue]) {
        case 1: ///关闭
        {
            [self exitBtnClick];
        }
            break;
        case 2: ///最小化
        {
            [self miniBtnClick];
        }
            break;
        case 3: ///房间上锁
        {
            [self roomLockState];
        }
            break;
        case 4: ///离开房间
        {
            [self leaveRoomClick];
        }
            break;
        default:
            break;
    }
    
}

///房间上锁
- (void)roomLockState{
    [HttpApiPublicLive liveRoomLock:![LiveManager liveInfo].roomModel.liveLockStatus liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        [SVProgressHUD showInfoWithStatus:strMsg];
    }];
    [[PopupTool share] closePopupView:self];
}

///离开房间
- (void)leaveRoomClick{
    [HttpApiPublicLive leaveRoomTemporarily:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
            [[PopupTool share] closePopupView:self];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)exitBtnClick{
    [LiveComponentMsgMgr sendMsg:LM_CloseLive msgDic:nil];
    [[PopupTool share] closePopupView:self];
}

- (void)miniBtnClick{
    [LiveManager showAudioMiniView];
    [LiveComponentMsgMgr sendMsg:LM_MiniLiveRoom msgDic:nil];
    [[PopupTool share] closePopupView:self];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


- (NSArray *)getFuncArr{
    NSMutableArray *funcMuArr = [[NSMutableArray alloc] init];
    
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPAudioLive:  ///多人语音
        {
            [funcMuArr addObject:@{@"funcId":@"2",@"title":kLocalizationMsg(@"最小化"), @"imgName":@"live_mini_white"}];
            ///
            if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor || [ProjConfig userId] == [LiveManager liveInfo].anchorId) {
                [funcMuArr addObject:@{@"funcId":@"3",@"title":kLocalizationMsg(@"房间上锁"), @"imgName":@"live_lock_white", @"selectImg":@"live_unlock_white"}];
            }
            ///房主
            if ([ProjConfig userId] == [LiveManager liveInfo].anchorId) {
                [funcMuArr addObject:@{@"funcId":@"4",@"title":kLocalizationMsg(@"离开房间"), @"imgName":@"live_leave_white"}];
            }
            [funcMuArr addObject:@{@"funcId":@"1",@"title":kLocalizationMsg(@"关闭"), @"imgName":@"live_exit_white"}];
        }
            break;
        case LiveTypeForMPVideoLive: ///多人视频
        {
            if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
                [funcMuArr addObject:@{@"funcId":@"3",@"title":kLocalizationMsg(@"房间上锁"), @"imgName":@"live_lock_white", @"selectImg":@"live_unlock_white"}];
                [funcMuArr addObject:@{@"funcId":@"1",@"title":kLocalizationMsg(@"关闭"), @"imgName":@"live_exit_white"}];
            }else{
            }
        }
            break;
        default:
            break;
    }
    return funcMuArr;
}


@end
