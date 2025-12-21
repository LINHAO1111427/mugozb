//
//  LiveNoticeView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveNoticeView.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>


@interface LiveNoticeView ()<UITextViewDelegate>

@property (nonatomic, weak)UILabel *numL;
@property (nonatomic, assign)NSInteger maxNum;
@property (nonatomic,weak)UITextView *textV;

@property (nonatomic, copy)NSString *noticeStr;

@end

@implementation LiveNoticeView

+ (void)changeRoomNotice{
    LiveNoticeView *notiveView = [[LiveNoticeView alloc] init];
    [notiveView createUI];
    [FunctionSheetBaseView controllerTitle:kLocalizationMsg(@"房间公告") detailView:notiveView rightBtn:kLocalizationMsg(@"发布") btnStrIsImage:NO clickBlock:^{
        [notiveView updateLiveNotice];
    }];
}

- (void)updateLiveNotice{
    if (_textV.text.length>_maxNum) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"已超出最大文字限度")];
        return;
    }
    
    int roomType = 0;
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPAudioLive:
        {
            roomType = 2;
        }
            break;
        case LiveTypeForMPVideoLive:
        case LiveTypeForShoppingLive:
        {
            roomType = 1;
        }
            break;
        default:
            break;
    }
    
    NSString *notice = _textV.text.length>0?_textV.text:@"";
    kWeakSelf(self);
    ///1多人视频2多人语音
    [HttpApiPublicLive updateLiveNotice:[ProjConfig userId] content:notice liveType:roomType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [LiveManager liveInfo].roomModel.notice = weakself.textV.text;
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [FunctionSheetBaseView deletePopView:weakself];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}


- (void)getLiveNotice{
    if ( _noticeStr > 0) {
        return;
    }
    int roomType = 0;
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPAudioLive:
        {
            roomType = 2;
        }
            break;
        case LiveTypeForMPVideoLive:
        case LiveTypeForShoppingLive:
        {
            roomType = 1;
        }
            break;
        default:
            break;
    }
    kWeakSelf(self);
    [HttpApiPublicLive getLiveNotice:[ProjConfig userId] liveType:roomType callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.noticeStr = model.no_use;
            weakself.textV.text = model.no_use;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)createUI{
    _noticeStr = [LiveManager liveInfo].roomModel.notice;
    
    _maxNum = 1000;
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.6);
    }];
    
    UITextView *textV = [[UITextView alloc] init];
    textV.layer.masksToBounds = YES;
    textV.layer.cornerRadius = 3;
    textV.layer.borderWidth = 0.8;
    textV.delegate = self;
    textV.text = _noticeStr;
    textV.placeholder = kLocalizationMsg(@"请填写房间公告");
    textV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textV.returnKeyType = UIReturnKeyDone;
    [self addSubview:textV];
    _textV = textV;
    
    UILabel *textLab = [[UILabel alloc] init];
    textLab.textColor = [UIColor lightGrayColor];
    textLab.font = [UIFont systemFontOfSize:10];
    [self addSubview:textLab];
    _numL = textLab;
    textLab.text = [NSString stringWithFormat:@"0/%zi",_maxNum];
    
    [textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(10);
        make.left.equalTo(self).mas_offset(20);
        make.right.equalTo(self).mas_offset(-20);
        make.bottom.equalTo(self).mas_offset(-(58+kSafeAreaBottom));
    }];
    
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textV).mas_offset(-10);
        make.right.equalTo(textV).mas_offset(-10);
    }];
    
    [self getLiveNotice];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        [self endEditing:YES];
    }

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > _maxNum) {
        textView.text = [textView.text substringToIndex:_maxNum];
    }
    _numL.text = [NSString stringWithFormat:@"%zi/%zi",textView.text.length,_maxNum];
}

@end
