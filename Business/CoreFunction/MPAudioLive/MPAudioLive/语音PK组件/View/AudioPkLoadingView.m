//
//  AudioPkLoadingView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/19.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "AudioPkLoadingView.h"
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiHttpVoice.h>

@interface AudioPkLoadingView()

@property(nonatomic,strong) UILabel *loadingPkLb;

/// 退出pk按钮
@property(nonatomic,strong) UIButton *quitPkBtn;


@end

@implementation AudioPkLoadingView

- (void)dealloc
{
    [_quitPkBtn removeFromSuperview];
    [_loadingPkLb removeFromSuperview];
}

+ (instancetype)showLoadingView{
    AudioPkLoadingView * loading = [[AudioPkLoadingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [FunctionSheetBaseView showTitle:nil detailView:loading cover:NO];
    return loading;
}


- (void)showStartPKResult:(LiveInfo_PKType)pkType code:(int)code{
    if (code == 1) {  ///成功
        [self pkLoadingShow:kLocalizationMsg(@"正在为你匹配PK主播...")];
        
    }
    if (code == 2) {
        
        NSString *pkTypeStr = @"";
        NSString *showStr = @"";
        
        switch (pkType) {
            case LivePKTypeForSingle:
            {
                pkTypeStr = kLocalizationMsg(@"单人PK");
                showStr = kLocalizationMsg(@"人数不足");
            }
                break;
            case LivePKTypeForTeam:
            {
                pkTypeStr = kLocalizationMsg(@"激情团战");
                showStr = kLocalizationMsg(@"麦上没有人，无法接入激情团战! 先邀请好友上麦吧。");
            }
                break;
            case LivePKTypeForRoom:
            {
                pkTypeStr = kLocalizationMsg(@"房间PK");
                showStr = kLocalizationMsg(@"房间内副播人数不足，不能发起房间PK! 先邀请好友上麦吧。");
            }
                break;
            default:
                break;
        }
        
        NSRange strRg = [showStr rangeOfString:pkTypeStr];
        if (strRg.length > 0) {
            NSMutableAttributedString *muAttStr = [[NSMutableAttributedString alloc] initWithString:showStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            [muAttStr setAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]} range:NSMakeRange(strRg.location, strRg.length+1)];
            [self showPkLoadingView:muAttStr];
        }
    }
}

- (void)pkLoadingShow:(NSString *)prompt{
    
    [self showPkLoadingView:[[NSAttributedString alloc] init]];
    
    [_loadingPkLb mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-50);
    }];
    _loadingPkLb.attributedText = [[NSAttributedString alloc] initWithString:prompt attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
    self.quitPkBtn.hidden = NO;
}


// MARK: - Lazy
- (UIButton *)quitPkBtn{
    if (_quitPkBtn == nil) {
        _quitPkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_quitPkBtn setTitle:kLocalizationMsg(@"退出Pk") forState:UIControlStateNormal];
        [_quitPkBtn setBackgroundColor: kRGB_COLOR(@"#925EFF")];
        [_quitPkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_quitPkBtn.layer setCornerRadius:20];
        [_quitPkBtn.layer setMasksToBounds:YES];
        [_quitPkBtn addTarget:self action:@selector(clickQuitPkBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_quitPkBtn];
        
        [_quitPkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(104, 40));
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-(28+kSafeAreaBottom));
        }];
    }
    return _quitPkBtn;
}


- (void)showPkLoadingView:(NSAttributedString *)attStr{
    if (!_loadingPkLb) {
        UILabel *loadingPkLb = [[UILabel alloc] init];
        loadingPkLb.font = [UIFont systemFontOfSize:14];
        loadingPkLb.textColor = kRGB_COLOR(@"#333333");
        loadingPkLb.numberOfLines = 0;
        loadingPkLb.textAlignment = NSTextAlignmentCenter;
        _loadingPkLb = loadingPkLb;
        [self addSubview:loadingPkLb];
        
        [loadingPkLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(-38);
            make.left.equalTo(self).mas_offset(70);
            make.right.equalTo(self).mas_offset(-70);
        }];
    }
    _loadingPkLb.attributedText = attStr;
}


// MARK: - Action
- (void)clickQuitPkBtn:(UIButton *)sender{
    [self dismissView];
    ///取消PK
    [HttpApiHttpVoice quitPK:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [LiveManager liveInfo].pkType = LivePKTypeForNormal;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)matchingTimeOut{
    [self pkLoadingShow:kLocalizationMsg(@"其他主播正忙，请耐心等待...")];
}

- (void)dismissView{
    [FunctionSheetBaseView deletePopView:self];
}

@end
