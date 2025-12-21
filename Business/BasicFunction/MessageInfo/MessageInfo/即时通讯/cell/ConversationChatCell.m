//
//  ConversationChatCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "ConversationChatCell.h"
#import "ShopChatMessageView.h"
#import "TimeTool.h"
#import "MessageChatModel.h"

#import <objc/runtime.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>
#import <AVFoundation/AVFoundation.h>

#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import "MessageShowRedPackView.h"
#import "MessageShowInviteOrderView.h"
#import "MessageShowGiftInfoView.h"
#import "MessageAllTextView.h"

#import "MessageUserJoinView.h"
#import "MessageSystemRedPtView.h"
#import "MessageUserInfoView.h"
#import "MsgSendStatusView.h"
#import "MessageShowOncePicView.h"

#import "ShowMsgPictureView.h"

#import <LibProjView/PopView.h>

@interface ConversationChatCell ()<ShopChatMessageViewDeleagte>

@property (nonatomic ,weak) UILabel *timeLabel;

@property (nonatomic ,weak) UILabel *decLabel;

@property (nonatomic, weak) MessageUserInfoView *userInfoV;///用户信息相关

@property (nonatomic, weak) ShopChatMessageView *shopView;///商品购买相关

@property (nonatomic, weak) MessageShowRedPackView *redPackView;///红包

@property (nonatomic, weak) MessageShowInviteOrderView *inviteOrderV; ///邀约订单

@property (nonatomic, weak) MessageShowGiftInfoView *giftView; //礼物

@property (nonatomic, weak) MessageTextView *textView; //文字消息

@property (nonatomic, weak) MessageOtoCallView *callView; ///一对一通话消息

@property (nonatomic, weak) MessageAudioView *audioView; ///语音消息

@property (nonatomic, weak) MessageAskGiftView *askGiftView; ///求赏消息

@property (nonatomic, weak) MessageUserJoinView *sysUserJoinV; ///用户加入消息

@property (nonatomic, weak) MessageSystemRedPtView *sysOpenRedPtV; ///用户抢红包的消息

@property (nonatomic, weak) MessageShowOncePicView *oncePic; ///阅后即焚图片

@property (nonatomic ,weak) UIImageView *picImageV;

@property (nonatomic, weak) MsgSendStatusView *statusView; ///发送状态

@property (nonatomic, weak) UILabel *readMsgL; ///已读消息

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)id timeObserver;

@end

@implementation ConversationChatCell

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kRGB_COLOR(@"#FAFAFA");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


//UI隐藏处理
- (void)forwardHidden{
    self.userInfoV.hidden = YES;
    self.shopView.hidden = YES;
    self.giftView.hidden = YES;
    self.timeLabel.hidden = YES;
    self.decLabel.hidden = YES;
    self.picImageV.hidden = YES;
    self.audioView.hidden = YES;
    self.callView.hidden = YES;
    self.askGiftView.hidden = YES;
    self.statusView.hidden = YES;
    self.redPackView.hidden = YES;
    self.inviteOrderV.hidden = YES;
    self.textView.hidden = YES;
    self.sysUserJoinV.hidden = YES;
    self.sysOpenRedPtV.hidden = YES;
    self.oncePic.hidden = YES;
    self.readMsgL.hidden = YES;
}

#pragma mark - 消息UI展示
-(void)setMModel:(MessageChatModel *)mModel{
    _mModel = mModel;
    [self forwardHidden];//隐藏UI
    [self showMessageItem:self.mModel.isOwner];
}



//语音播放状态
- (void)setIsPlayingVoice:(BOOL)isPlayingVoice{
    _isPlayingVoice = isPlayingVoice;
    if (!isPlayingVoice) {
        [self.audioView.audioImgView stopAnimating];
        [self.player pause];
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
        self.player = nil;
    }else{
        [self.audioView.audioImgView startAnimating];
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.mModel.voiceMsg.recordUrl]];
        self.player = [[AVPlayer alloc]initWithPlayerItem:item];
        [self.player play];
        __weak typeof(self) weakSelf = self;
        self.timeObserver =[self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0,1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            CMTime duration = weakSelf.player.currentItem.duration;
            float totalSeconds = CMTimeGetSeconds(duration);
            float currentSeconds = CMTimeGetSeconds(time);
            float rate = currentSeconds/totalSeconds;
            if (rate >= 0.99) {
                weakSelf.isPlayingVoice = NO;
                [weakSelf.audioView.audioImgView stopAnimating];
            }
        }];
    }
}

//显示具体消息
- (void)showMessageItem:(BOOL)isOwner{
    CGFloat showTimeHeight = [self showMessageTimeHeight];
    if (self.mModel.isCancelMsg) {
        self.decLabel.frame = CGRectMake(0, showTimeHeight, kScreenWidth, 30);
        self.decLabel.hidden = NO;
        self.decLabel.textAlignment = NSTextAlignmentCenter;
        NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"%@撤回了一条消息"),isOwner?kLocalizationMsg(@"你"):kStringFormat(@"“%@”",self.mModel.sendUserInfo.userName)];
        self.decLabel.text = showStr;
        return;
    }
    
    self.userInfoV.frame = CGRectMake(0, showTimeHeight, kScreenWidth, 60);
    [self.userInfoV showUserInfoIsOwner:isOwner isGroup:self.mModel.isGroupMsg userInfo:self.mModel.sendUserInfo];
    
    
    CGFloat msgY = showTimeHeight+self.userInfoV.msgY;
    CGFloat msgLeftX = self.userInfoV.msgLeftX;
    
    switch (self.mModel.messageType) {
        case IMMessageTypeForPicture://图片
        {
            self.picImageV.hidden = NO;
            self.userInfoV.hidden = NO;
            self.picImageV.frame = CGRectMake(msgLeftX, msgY, 120, 150);
            [self.picImageV sd_setImageWithURL:[NSURL URLWithString:self.mModel.picMsg.picUrlStr] placeholderImage:[UIImage imageNamed:@"loading"]];
            if (isOwner) {
                self.picImageV.x = kScreenWidth - msgLeftX - self.picImageV.width;
                [self.statusView showMsgStatus:_mModel.imMessage.sendStatus extra:_mModel.msgExtraDict];
                self.statusView.frame = CGRectMake(self.picImageV.x - 25, msgY + (self.picImageV.height-20)/2 , 20, 20);
            }
            [self readMsgTopView:self.picImageV isOwner:isOwner];
        }
            break;
        case IMMessageTypeForGift://礼物
        {
            self.giftView.hidden = NO;
            self.giftView.frame = CGRectMake(0, showTimeHeight + 12,kScreenWidth, 50);
            [self.giftView showGiftInfo:self.mModel.giftMsg isGroup:self.mModel.isGroupMsg isOwn:isOwner];
        }
            break;
        case IMMessageTypeForAudio://语音
        {
            self.audioView.hidden = NO;
            self.userInfoV.hidden = NO;
            self.audioView.frame = CGRectMake(msgLeftX , msgY, 100, 34);
            [self.audioView showMsgIsOwner:isOwner time:self.mModel.voiceMsg.audioTimeStr];
            
            if (isOwner) {
                self.audioView.x = kScreenWidth-msgLeftX-self.audioView.width;
                [self.statusView showMsgStatus:_mModel.imMessage.sendStatus extra:_mModel.msgExtraDict];
                self.statusView.frame = CGRectMake(self.audioView.x - 25, msgY + (self.audioView.height-20)/2 , 20, 20);
            }else{
                
            }
            [self readMsgTopView:self.audioView isOwner:isOwner];
        }
            break;
        case IMMessageTypeForVideo://视频
        {}
            break;
        case IMMessageTypeFor1v1Voice://1v1语音
        case IMMessageTypeFor1v1Video://1v1视频
        {
            self.userInfoV.hidden = NO;
            self.callView.hidden = NO;
            NSString *contentStr = self.mModel.otoCallMsg.otoStatusStr;
            CGSize textSize = [MessageChatModel getTextSizeWithContentString:contentStr];
            
            self.callView.frame = CGRectMake(msgLeftX, msgY, textSize.width + 30 + 25, MAX(textSize.height + 10, 34));
            
            [self.callView showOtoCallStr:contentStr isVideo:self.mModel.otoCallMsg.isVideo isOwner:isOwner];
            if (isOwner) {
                self.callView.x = kScreenWidth - msgLeftX - self.callView.width;
            }else{
            }
        }
            break;
        case IMMessageTypeForText://文字
        {
            self.userInfoV.hidden = NO;
            self.textView.hidden = NO;
            CGSize textSize = [MessageChatModel getTextSizeWithContentString:self.mModel.textMsg.contentStr];
            
            self.textView.frame = CGRectMake(msgLeftX, msgY, textSize.width + 30, MAX(textSize.height + 10, 34));
            
            [self.textView showTopIsOwner:isOwner content:self.mModel.textMsg.contentStr isTop:self.mModel.textMsg.isTop];
            if (isOwner) {
                self.textView.x = kScreenWidth - msgLeftX - self.textView.width;
                [self.statusView showMsgStatus:_mModel.imMessage.sendStatus extra:_mModel.msgExtraDict];
                self.statusView.frame = CGRectMake(self.textView.x - 25, msgY + (self.textView.height-20)/2 , 20, 20);
            }else{
                
            }
            [self readMsgTopView:self.textView isOwner:isOwner];
        }
            break;
        case IMMessageTypeForGroupTip://群组提示
        {
            self.decLabel.hidden = NO;
            self.decLabel.text = self.mModel.sysNoticeMsg.noticeStr;
            CGFloat decLabelH = [self.decLabel.text heightWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:kScreenWidth - 120];
            self.decLabel.frame =  CGRectMake(60, showTimeHeight + 12 ,kScreenWidth - 120, decLabelH);
        }
            break;
        case IMMessageTypeForShopping://购物消息
        {
            self.userInfoV.hidden = NO;
            self.shopView.hidden = NO;
            CGFloat widthCell = kScreenWidth*487/750.0;
            self.shopView.frame = CGRectMake(msgLeftX, msgY, widthCell + 30, self.mModel.shoppingMsg.viewHeight);
            if (isOwner) {
                self.shopView.x = kScreenWidth - msgLeftX -self.shopView.width;
            }
            [self.shopView showShopMessageInfo:self.mModel.shoppingMsg isOwner:isOwner];
            [self readMsgTopView:self.shopView isOwner:isOwner];
        }
            break;
        case IMSystemMsgTypeForGroupRedPt:
        case IMMessageTypeForRedPack://红包消息
        {
            self.userInfoV.hidden = NO;
            self.redPackView.hidden = NO;
            self.redPackView.frame = CGRectMake(msgLeftX, msgY , 200, 100);
            [self.redPackView showRedPtInfo:self.mModel.redPacketMsg isOwn:isOwner];
            if (isOwner) {
                self.redPackView.x = kScreenWidth - msgLeftX - self.redPackView.width;
            }
            [self readMsgTopView:self.redPackView isOwner:isOwner];
        }
            break;
        case IMMessageTypeForShowOncePic://阅后即焚图片
        {
            self.oncePic.hidden = NO;
            self.userInfoV.hidden = NO;
            self.oncePic.frame = CGRectMake(msgLeftX, msgY, 80, 80);
            [self.oncePic showPic:self.mModel.oncePicMsg isOwner:isOwner];
            if (isOwner) {
                self.oncePic.x = kScreenWidth - msgLeftX - self.oncePic.width;
                [self.statusView showMsgStatus:_mModel.imMessage.sendStatus extra:_mModel.msgExtraDict];
                self.statusView.frame = CGRectMake(self.picImageV.x - 25, msgY + (self.picImageV.height-20)/2 , 20, 20);
            }
            [self readMsgTopView:self.oncePic isOwner:isOwner];
        }
            break;
        case IMMessageTypeForInviteOrder://邀请订单
        {
            self.inviteOrderV.hidden = NO;
            self.inviteOrderV.frame = CGRectMake(20, showTimeHeight + 12 , kScreenWidth-40, self.mModel.messageCellHeight-10);
            self.inviteOrderV.titleL.text = self.mModel.inviteOrderMsg.title;
            self.inviteOrderV.contentL.text = self.mModel.inviteOrderMsg.content;
        }
            break;
        case IMSystemMsgTypeForAskGift://求赏
        {
            self.askGiftView.hidden = NO;
            self.userInfoV.hidden = NO;
            self.askGiftView.frame = CGRectMake(msgLeftX, msgY, self.mModel.messageWidth, self.mModel.messageCellHeight-20);
            if (isOwner) {
                self.askGiftView.x = kScreenWidth - msgLeftX -self.askGiftView.width;
            }
            [self.askGiftView showMsgIsOwner:self.mModel.isOwner giftIcon:self.mModel.askGiftMsg.giftIcon showStr:self.mModel.askGiftMsg.showStr];
            [self readMsgTopView:self.askGiftView isOwner:isOwner];
        }
            break;
        case IMMessageTypeForunknown://未知消息
        {}
            break;
        case IMSystemMsgTypeForJoinFamily://系统发的加入家族消息
        {
            self.sysUserJoinV.hidden = NO;
            self.sysUserJoinV.frame = CGRectMake(20, showTimeHeight + 12, kScreenWidth-40, self.mModel.messageCellHeight-10);
            [self.sysUserJoinV welconUserNameJoinRoom:self.mModel.sysJoinFamilyMsg.userName];
        }
            break;
        case IMSystemMsgTypeForOpenRedPt://系统发的用户收红包消息
        {
            self.sysOpenRedPtV.hidden = NO;
            self.sysOpenRedPtV.frame = CGRectMake(20, showTimeHeight + 12, kScreenWidth-40, self.mModel.messageCellHeight-10);
            [self.sysOpenRedPtV showSystemRedPt:self.mModel.sysOpenRedPtMsg];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 消息处理
//时间高度
-(CGFloat)showMessageTimeHeight{
    NSString *time = [TimeTool getTimeStringAutoShort2:self.mModel.messageTimeDate mustIncludeTime:YES];
    CGSize size = [time sizeWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:20];
    self.timeLabel.frame =  CGRectMake(kScreenWidth/2. - size.width/2. -15, 5,size.width + 30, 20);
    self.timeLabel.text = time;
    self.timeLabel.hidden = (self.mModel.isShowTime?NO:YES);
    return self.mModel.messageTimeHeight;
}


- (void)inviteOrderBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conversationChatCell:invitOrder:)]) {
        [self.delegate conversationChatCell:self invitOrder:self.mModel.inviteOrderMsg];
    }
}

///设置消息的已读未读
- (void)readMsgTopView:(UIView *)topView isOwner:(BOOL)isOwner{
    if (isOwner && !self.mModel.isGroupMsg) {
        self.readMsgL.hidden = NO;
        self.readMsgL.frame = CGRectMake(self.textView.maxX-50, self.textView.maxY+2, 50, 15);
        self.readMsgL.text = self.mModel.imMessage.msgIsRead ? kLocalizationMsg(@"已读"):kLocalizationMsg(@"未读");
    }
}

#pragma mark - 手势 按钮
- (void)playAudioFile:(UITapGestureRecognizer *)tap{
    if (self.mModel.messageType != IMMessageTypeForAudio) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(conversationChatCell:voicePlayStatus:)]) {
        [self.delegate conversationChatCell:self voicePlayStatus:self.isPlayingVoice];
    }
}
///点击送礼的信息
- (void)tapGiftUserHeader:(BOOL)isOwner{
    if (self.clickHeaderImageBlock) {
        int64_t clickUid = 0;
        if (isOwner) {
            clickUid = self.mModel.giftMsg.ownUid;
        }else{
            clickUid = self.mModel.giftMsg.otherUid;
        }
        if (clickUid > 0) {
            self.clickHeaderImageBlock?self.clickHeaderImageBlock(clickUid):nil;
        }
    }
}

///点击用户加入的信息
- (void)tapJoinFamilyToUserInfo{
    if (self.clickHeaderImageBlock) {
        self.clickHeaderImageBlock(self.mModel.sysJoinFamilyMsg.userId);
    }
}
///点击欢迎
- (void)tapWelcomeInfo{
    if (self.delegate) {
        [self.delegate conversationChatCell:self welcomeUser:self.mModel.sysJoinFamilyMsg];
    }
}


-(void)picImageVTap:(UITapGestureRecognizer *)tap{
    [ShowMsgPictureView showImage:self.picImageV picUrl:self.mModel.picMsg.picUrlStr];
}


- (void)askGiftBtnClick:(UITapGestureRecognizer *)tap{
    if (!self.mModel.isOwner) {
        self.delegate?[self.delegate conversationChatCell:self sendAskGift:self.mModel.askGiftMsg]:nil;
    }
}

///阅后即焚图片点击
- (void)showOncePicTap:(UITapGestureRecognizer *)tap{
    if (self.mModel.isOwner || self.mModel.oncePicMsg.readStatus == 0) {
        kWeakSelf(self);
        [ShowMsgPictureView showOncePic:tap.view isOwner:self.mModel.isOwner picUrl:self.mModel.oncePicMsg.picUrlStr showBlock:^(BOOL look) {
            if (look) {
                weakself.delegate?[weakself.delegate conversationChatCell:weakself showOncePic:weakself.mModel.oncePicMsg]:nil;
            }
        }];
    }
}

-(void)resendAction{
   // NSLog(@"过滤文字重发"));
    ///发送新消息
    if ([self.delegate respondsToSelector:@selector(conversationChatCell:resendMessage:)]) {
        [self.delegate conversationChatCell:self resendMessage:YES];
    }
    ///删除旧消息
    if (self.delegate) {
        [self.delegate conversationChatCell:self deleteMsg:self.mModel];
    }
}

#pragma mark - ShopChatMessageViewDeleagte
- (void)commodityDetailInfo:(MessageChatModel *)model{
    if ([self.delegate respondsToSelector:@selector(conversationChatCell:shopChat:)]) {
        [self.delegate conversationChatCell:self shopChat:self.mModel];
    }
}

#pragma mark - cell长按显示功能按钮
///给每一个视图添加长按功能按钮
- (void)viewAddLongPGTap:(UIView *)view{
    UILongPressGestureRecognizer *longPG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPGHandle:)];
    [view addGestureRecognizer:longPG];
}

///长按显示
- (void)longPGHandle:(UILongPressGestureRecognizer *)longPG{
    
    if (longPG.state == UIGestureRecognizerStateBegan) {
        UIView *tapView = longPG.view;
        IMMessageType msgType = self.mModel.messageType;
        NSMutableArray *itemArr = [[NSMutableArray alloc] init];
        [itemArr addObject:@{@"title":kLocalizationMsg(@"删除"),@"type":@"1"}];
        if (msgType == IMMessageTypeForText) {
            [itemArr addObject:@{@"title":kLocalizationMsg(@"复制"),@"type":@"2"}];
        }
        if (msgType == IMMessageTypeForPicture || msgType == IMMessageTypeForVideo || msgType == IMMessageTypeForText || msgType == IMMessageTypeForShowOncePic) {
            if (!self.mModel.isCancelMsg && [TimeTool judgeBetweenSecond:self.mModel.messageTimeDate lastTime:[NSDate date]]<=120) {
                [itemArr addObject:@{@"title":kLocalizationMsg(@"撤回"),@"type":@"3"}];
            }
        }
        CGFloat viewW = 60;
        CGFloat viewH = 30;
        UIView *funcV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW*itemArr.count+30, viewH+20)];
        funcV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        funcV.layer.cornerRadius = 10;
        for (int i = 0; i< itemArr.count; i++) {
            NSDictionary *param = itemArr[i];
            UIButton *btn = [UIButton buttonWithType:0];
            btn.frame = CGRectMake(15+i*viewW, 10, viewW, viewH);
            [btn setTitle:param[@"title"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.tag =  9878+[param[@"type"] intValue];
            [btn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [funcV addSubview:btn];
        }
        [PopView popUpContentView:funcV direct:PopViewDirection_PopUpTop onView:tapView];
    }
}

- (void)funcBtnClick:(UIButton *)btn{
    
    [PopView hidenPopView];
    
    switch (btn.tag - 9878) {
        case 1:
        {
            if (self.delegate) {
                [self.delegate conversationChatCell:self deleteMsg:self.mModel];
            }
        }
            break;
        case 2: ///复制
        {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"复制成功!")];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.mModel.textMsg.contentStr;
        }
            break;
        case 3: ///撤回
        {
            [self.delegate conversationChatCell:self cancelMsg:self.mModel];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 懒加载

- (UILabel *)readMsgL{
    if (!_readMsgL && [[ProjConfig shareInstence].baseConfig msgHasReadInfo]) {
        UILabel *readMsgL = [[UILabel alloc] init];
        readMsgL.textColor = [UIColor lightGrayColor];
        readMsgL.textAlignment = NSTextAlignmentRight;
        readMsgL.font = [UIFont systemFontOfSize:10];
        [self addSubview:readMsgL];
        _readMsgL = readMsgL;
    }
    return _readMsgL;
}

- (UILabel *)decLabel{
    if (nil == _decLabel) {
        UILabel *decLabel = [[UILabel alloc] init];
        decLabel.textColor = [UIColor grayColor];
        decLabel.numberOfLines = 0;
        [decLabel.layer setCornerRadius:12];
        [decLabel setClipsToBounds:YES];
        [decLabel setTextAlignment:NSTextAlignmentCenter];
        [decLabel setFont:[UIFont systemFontOfSize:12]];
        decLabel.hidden = YES;
        [self.contentView addSubview:decLabel];
        _decLabel = decLabel;
    }
    return _decLabel;
}

- (UILabel *)timeLabel{
    if (nil == _timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor grayColor];
        [timeLabel.layer setCornerRadius:10];
        [timeLabel setClipsToBounds:YES];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setFont:[UIFont systemFontOfSize:14]];
        timeLabel.hidden = YES;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}

- (MessageUserInfoView *)userInfoV{
    if (!_userInfoV) {
        kWeakSelf(self);
        MessageUserInfoView *userInfo = [[MessageUserInfoView alloc] init];
        [self.contentView addSubview:userInfo];
        userInfo.userAvatarClick = ^{
            self.delegate?[self.delegate conversationChatCell:weakself userInfoClick:weakself.mModel.sendUserInfo]:nil;
        };
        _userInfoV = userInfo;
    }
    return _userInfoV;
}

- (MessageShowGiftInfoView *)giftView{
    if (!_giftView) {
        MessageShowGiftInfoView *giftView = [[MessageShowGiftInfoView alloc] init];
        kWeakSelf(self);
        [giftView.giftOtherHeadV klc_whenTapped:^{
            [weakself tapGiftUserHeader:NO];
        }];
        [giftView.giftHeadV klc_whenTapped:^{
            [weakself tapGiftUserHeader:YES];
        }];
        [self.contentView addSubview:giftView];
        [self viewAddLongPGTap:giftView];
        giftView.hidden = YES;
        _giftView = giftView;
    }
    return _giftView;
}

- (UIImageView *)picImageV{
    if (!_picImageV) {
        UIImageView *picImageV = [[UIImageView alloc]init];
        [picImageV.layer setCornerRadius:5.];
        picImageV.contentMode = UIViewContentModeScaleAspectFill;
        [picImageV setClipsToBounds:YES];
        [self.contentView addSubview:picImageV];
        [self viewAddLongPGTap:picImageV];
        picImageV.hidden = YES;
        picImageV.userInteractionEnabled = YES;
        picImageV.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.1];
        UITapGestureRecognizer *picImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picImageVTap:)];
        [picImageV addGestureRecognizer:picImageTap];
        _picImageV = picImageV;
    }
    return _picImageV;
}


- (MsgSendStatusView *)statusView{
    if (!_statusView) {
        kWeakSelf(self);
        MsgSendStatusView *statusView = [[MsgSendStatusView alloc] init];
        statusView.chatType = self.chatType;
        [self.contentView addSubview:statusView];
        statusView.reSendBtnClick = ^{
            [weakself resendAction];
        };
        _statusView = statusView;
    }
    return _statusView;
}

- (ShopChatMessageView *)shopView{
    if (!_shopView) {
        ShopChatMessageView *shopView = [[ShopChatMessageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        shopView.backgroundColor = [UIColor whiteColor];
        shopView.delegate = self;
        shopView.layer.cornerRadius = 10;
        shopView.clipsToBounds = YES;
        [self.contentView addSubview:shopView];
        [self viewAddLongPGTap:shopView];
        _shopView = shopView;
    }
    return _shopView;
}

- (MessageShowRedPackView *)redPackView{
    if (!_redPackView) {
        kWeakSelf(self);
        MessageShowRedPackView *redPackView = [[MessageShowRedPackView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        redPackView.backgroundColor = kRGBA_COLOR(@"#EC9742", 1.0);
        redPackView.layer.cornerRadius = 10;
        redPackView.clipsToBounds = YES;
        redPackView.clickRedPt = ^{
            if (weakself.delegate) {
                [weakself.delegate conversationChatCell:weakself redPacket:weakself.mModel.redPacketMsg];
            }
        };
        [self.contentView addSubview:redPackView];
        [self viewAddLongPGTap:redPackView];
        _redPackView = redPackView;
    }
    return _redPackView;
}

- (MessageShowInviteOrderView *)inviteOrderV{
    if (!_inviteOrderV) {
        MessageShowInviteOrderView *inviteOrderV = [[MessageShowInviteOrderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        inviteOrderV.backgroundColor = [UIColor whiteColor];
        kWeakSelf(self);
        [inviteOrderV klc_whenTapped:^{
            [weakself inviteOrderBtnClick];
        }];
        [self.contentView addSubview:inviteOrderV];
        [self viewAddLongPGTap:inviteOrderV];
        _inviteOrderV = inviteOrderV;
    }
    return _inviteOrderV;
}

- (MessageTextView *)textView{
    if (!_textView) {
        MessageTextView *textV = [[MessageTextView alloc] init];
        [self.contentView addSubview:textV];
        [self viewAddLongPGTap:textV];
        _textView = textV;
    }
    return _textView;
}

- (MessageOtoCallView *)callView{
    if (!_callView) {
        MessageOtoCallView *textV = [[MessageOtoCallView alloc] init];
        [self.contentView addSubview:textV];
        [self viewAddLongPGTap:textV];
        _callView = textV;
    }
    return _callView;
}

- (MessageAudioView *)audioView{
    if (!_audioView) {
        MessageAudioView *textV = [[MessageAudioView alloc] init];
        [self.contentView addSubview:textV];
        [self viewAddLongPGTap:textV];
        _audioView = textV;
        UITapGestureRecognizer *audioTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playAudioFile:)];
        [textV addGestureRecognizer:audioTap];
    }
    return _audioView;
}

- (MessageUserJoinView *)sysUserJoinV{
    if (!_sysUserJoinV) {
        kWeakSelf(self);
        MessageUserJoinView *joinMsg = [[MessageUserJoinView alloc] init];
        [self.contentView addSubview:joinMsg];
        [self viewAddLongPGTap:joinMsg];
        [joinMsg.nameBtn klc_whenTapped:^{
            [weakself tapJoinFamilyToUserInfo];
        }];
        [joinMsg.welcomeBtn klc_whenTapped:^{
            [weakself tapWelcomeInfo];
        }];
        _sysUserJoinV = joinMsg;
    }
    return _sysUserJoinV;
}

- (MessageSystemRedPtView *)sysOpenRedPtV{
    if (!_sysOpenRedPtV) {
        MessageSystemRedPtView *openRedPt = [[MessageSystemRedPtView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self.contentView addSubview:openRedPt];
        [self viewAddLongPGTap:openRedPt];
        kWeakSelf(self);
        openRedPt.clickUserInfo = ^(int64_t userId) {
            if (weakself.clickHeaderImageBlock) {
                weakself.clickHeaderImageBlock(userId);
            }
        };
        _sysOpenRedPtV = openRedPt;
    }
    return _sysOpenRedPtV;
}


- (MessageAskGiftView *)askGiftView{
    if (!_askGiftView) {
        MessageAskGiftView *askGiftV = [[MessageAskGiftView alloc] init];
        [self.contentView addSubview:askGiftV];
        _askGiftView = askGiftV;
        UITapGestureRecognizer *askGiftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(askGiftBtnClick:)];
        [askGiftV addGestureRecognizer:askGiftTap];
    }
    return _askGiftView;
}

- (MessageShowOncePicView *)oncePic{
    if (!_oncePic) {
        MessageShowOncePicView *oncePic = [[MessageShowOncePicView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [self.contentView addSubview:oncePic];
        _oncePic = oncePic;
        [self viewAddLongPGTap:oncePic];
        UITapGestureRecognizer *oncePicTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOncePicTap:)];
        [oncePic addGestureRecognizer:oncePicTap];
    }
    return _oncePic;
}

@end
