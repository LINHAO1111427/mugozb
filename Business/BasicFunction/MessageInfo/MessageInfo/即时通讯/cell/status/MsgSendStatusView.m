//
//  MsgSendStatusView.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/24.
//

#import "MsgSendStatusView.h"
#import <LibProjView/SendIMMessageObj.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>


@implementation MsgSendStatusView

- (UIImageView *)sendFailView{
    if (!_sendFailView) {
        kWeakSelf(self);
        UIImageView *sendFailView = [[UIImageView alloc] init];
        [sendFailView setUserInteractionEnabled:YES];
        [sendFailView setImage:[UIImage imageNamed:@"message_sendfail"]];
        [self addSubview:sendFailView];
        [sendFailView klc_whenTapped:^{
            [weakself clickReSendBtn];
        }];
        _sendFailView = sendFailView;
        [sendFailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _sendFailView;
}

- (UIActivityIndicatorView *)circleView{
    if (!_circleView) {
        UIActivityIndicatorView *circleView = [UIActivityIndicatorView new];
        [circleView setBackgroundColor:[UIColor clearColor]];
        [circleView setHidden:NO];
        circleView.hidesWhenStopped = YES;
        [self addSubview:circleView];
        _circleView = circleView;
        [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _circleView;
}


- (void)showMsgStatus:(int)code extra:(NSDictionary *)extra{
    
    ///已缓存中
    int sendStatus = [extra[@"sendStatus"] intValue];
    if (sendStatus != 0 && sendStatus != 1) {
        code = sendStatus;
    }
    
    _msgCode = code;
    _extraInfo = extra;
    
    switch (code) {
        case IMMessageSendStatusForCheck: ///发送检测中
        {
            self.hidden = NO;
            [self.circleView stopAnimating];
            self.sendFailView.image = [UIImage imageNamed:@"message_sendcheck"];
            [self.sendFailView setHidden:NO];
        }
            break;
        case IMMessageSendStatusForWaiting: ///发送等待中
        {
            self.hidden = NO;
            [self.circleView startAnimating];
            [self.sendFailView setHidden:YES];
        }
            break;
        case IMMessageSendStatusForSilenced:///已被禁言
        case IMMessageSendStatusForFail: ///发送失败
        case IMMessageSendStatusForTimeout: ///发送超时
        case IMMessageSendStatusForGroupDissolve: ///家族已经解散
        case IMMessageSendStatusForGroupKicked: ///已被踢出家族
        case IMMessageSendStatusForCheckFail: ///检测信息没过关
        {
            self.hidden = NO;
            [self.circleView stopAnimating];
            self.sendFailView.image = [UIImage imageNamed:@"message_sendfail"];
            [self.sendFailView setHidden:NO];
        }
            break;
        case IMMessageSendStatusForSuccess: ///发送成功
        {
            self.hidden = YES;
            [self.circleView stopAnimating];
            [self.sendFailView setHidden:YES];
        }
            break;
        default:
            self.hidden = YES;
            break;
    }
}

- (void)clickReSendBtn{
    
    switch (self.msgCode) {
        case IMMessageSendStatusForCheck:
        case IMMessageSendStatusForCheckFail:
        {
            [SVProgressHUD showInfoWithStatus:self.extraInfo[@"hint"]];
        }
            break;
        case IMMessageSendStatusForGroupDissolve:
        {
            switch (self.chatType) {
                case ConversationChatForSquareGroup:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"广场已解散～")];
                    break;
                case ConversationChatForFamilyGroup:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"家族已解散～")];
                    break;
                case ConversationChatForFansGroup:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"粉丝团已解散～")];
                    break;
                default:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"群组已解散～")];
                    break;
            }
            
        }
            break;
        case IMMessageSendStatusForGroupKicked:
        {
            switch (self.chatType) {
                case ConversationChatForSquareGroup:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您已被踢出广场～")];
                    break;
                case ConversationChatForFamilyGroup:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您已被踢出家族～")];
                    break;
                case ConversationChatForFansGroup:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您已被踢出粉丝团～")];
                    break;
                default:
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"您已被踢出群组～")];
                    break;
            }
        }
            break;
        default:
        {
            self.reSendBtnClick?self.reSendBtnClick():nil;
        }
            break;
    }
}

@end
