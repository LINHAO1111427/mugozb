//
//  LiveInputView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/1.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveInputView.h"
 
#import "LiveManager.h"
 
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
 
#import <LibProjModel/HttpApiNobleController.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/ApiBaseEntityModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/HttpApiRoomPublicController.h>

@interface LiveInputView ()

@property (nonatomic, weak)UIButton *barrageBtn;
@property (nonatomic, weak)UITextField *textF;

@end

@implementation LiveInputView

- (void)dealloc
{
    [self removeNotifacation];
}

+ (void)showInputView:(NSString *)str{
    UIView *inputV =[PopupTool getPopupViewForClass:[LiveInputView class]];
    if (!inputV) {
        LiveInputView *inputV = [[LiveInputView alloc] init];
        [inputV createUI:str];
    }
}

- (void)createUI:(NSString *)showStr{
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.backgroundColor = [UIColor whiteColor];
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES popupBgViewAction:@selector(dismissView) popupBgViewTarget:self cover:NO];
    
    UIButton *changeBtn = [UIButton buttonWithType:0];
    changeBtn.frame = CGRectMake(12, 10, 40, 20);
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"live_danmu_nor"] forState:UIControlStateNormal];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"live_danmu_sel"] forState:UIControlStateSelected];
    [changeBtn addTarget:self action:@selector(clickSwitchBarrage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeBtn];
    _barrageBtn = changeBtn;
    
    UIButton *sendBtn = [UIButton buttonWithType:0];
    sendBtn.frame = CGRectMake(kScreenWidth-10-40, 5, 40, 30);
    [sendBtn setTitle:kLocalizationMsg(@"发送") forState:UIControlStateNormal];
    [sendBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendBtn];
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(changeBtn.maxX+15, 10, sendBtn.x-15-(changeBtn.maxX+15), 20)];
    textF.backgroundColor = [UIColor whiteColor];
    textF.font = [UIFont systemFontOfSize:13];
    textF.placeholder = kLocalizationMsg(@"说点什么...");
    [textF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textF];
    _textF = textF;
    
    if (showStr.length > 0) {
        textF.text = [NSString stringWithFormat:@"%@ ",showStr];
    }
    
    [self addNotifacation];
    
    [textF becomeFirstResponder];
}

- (void)dismissView{
    [self endEditing:YES];
}

// MARK: - Action -
/// 点击切换 弹幕/普通消息 按钮
- (void)clickSwitchBarrage:(UIButton *)sender{
    kWeakSelf(self);
    sender.selected = !sender.isSelected;
    if (sender.isSelected == YES) { // 弹幕消息
        //下面两个方案目前均可行
        ///0：未开启1：无特权 2：有特权
        [HttpApiNobleController getIsOwnerPrivilege:4005 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                if ([model.no_use intValue] == 2) {
                    weakself.textF.placeholder = [NSString stringWithFormat:kLocalizationMsg(@"贵族免费发弹幕")];
                }else{
                    weakself.textF.placeholder = [NSString stringWithFormat:kLocalizationMsg(@"开启大喇叭，%d%@/条"),[KLCAppConfig appConfig].adminLiveConfig.barrageFee,[KLCAppConfig unitStr]];
                }
            }else{
                weakself.textF.placeholder = [NSString stringWithFormat:kLocalizationMsg(@"开启大喇叭，%d%@/条"),[KLCAppConfig appConfig].adminLiveConfig.barrageFee,[KLCAppConfig unitStr]];
            }
        }];
        /*
        if ([LiveManager liveInfo].roomModel.gzdmPrivilege || [LiveManager liveInfo].otoModel.gzdmPrivilege) {
            _textF.placeholder = [NSString stringWithFormat:kLocalizationMsg(@"贵族免费发弹幕")];
        }else{
             _textF.placeholder = [NSString stringWithFormat:kLocalizationMsg(@"开启大喇叭，%d%@/条"),[KLCAppConfig appConfig].adminLiveConfig.barrageFee,[KLCAppConfig unitStr]];
        }
         */
    }
    else{                           // 普通消息
        _textF.placeholder = kLocalizationMsg(@"和大家说些什么吧");
    }
}

- (void)sendBtnClick:(UIButton *)sendBtn{
    if (_textF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"说点什么吧～")];
        return;
    }
    
    //     1、发送消息socket
    [HttpApiRoomPublicController sendMsgRoom:[LiveManager liveInfo].anchorId content:_textF.text liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId type:_barrageBtn.isSelected ? 2 : 1 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
    // 2、收起键盘
    _textF.text = @"";
    [self endEditing:YES];
}

- (void)textFieldChanged:(UITextField *)sender{
//   // NSLog(@"过滤文字=======textFieldChanged========"));
//    if (sender.text.length == 0) {
//        [_sendBtn setEnabled:NO];
//    }
//    else{
//        [_sendBtn setEnabled:YES];
//    }
}



#pragma mark - NSNotification
- (void)removeNotifacation{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addNotifacation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 键盘出现通知
 */
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    CGRect keyboardRect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    kWeakSelf(self);
    [UIView animateWithDuration:time animations:^{
        CGRect rc = weakself.frame;
        rc.origin.y = keyboardRect.origin.y-rc.size.height;
        weakself.frame = rc;
    }];
}


// MARK: 键盘消失回调
- (void)keyboardWillHide:(NSNotification *)aNotification{
    kWeakSelf(self);
    NSTimeInterval time = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        CGRect rc = weakself.frame;
        rc.origin.y = kScreenHeight;
        weakself.frame = rc;
    } completion:^(BOOL finished) {
        [[PopupTool share] closePopupView:weakself];
        [weakself removeFromSuperview];
    }];
}



@end
