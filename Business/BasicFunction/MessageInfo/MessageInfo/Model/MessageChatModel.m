//
//  MessageModel.m
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import "MessageChatModel.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjModel/UserGroupIdDtoModel.h>
#import <LibProjModel/AppIdBOModel.h>
#import <LibProjBase/LibProjBase.h>
#import  <SDWebImage/SDWebImage.h>
#import "TimeTool.h"


@implementation GroupMessageObj

@end

@implementation SingleMessageObj

@end

@implementation SendMsgUserInfoObj

@end




@implementation MessageChatModel


- (instancetype)initWithChatMessage:(V2TIMMessage *)message
{
    self = [super init];
    if (self) {
        
        [self setChatMessage:message];
    }
    return self;
}


- (void)setChatMessage:(V2TIMMessage *)message{
    
    ImMessage *msg = [[ImMessage alloc]initWith:message];
    self.isGroupMsg = message.groupID.length > 0 ? YES:NO;
     
    
    
    ///展示在会话列表的聊天对象基本信息
    {
        int64_t UGID;
        if (message.groupID.length > 0) {
            UGID =  [message.groupID longLongValue];
        }else{
            UGID =  [message.userID longLongValue];
        }
        ImExtraInfo *info = [[IMSocketIns getIns] getExtraInfo:UGID];
        NSDictionary *chatExtInfo = info.extraInfo;
       
        if (self.isGroupMsg) {
            
            GroupMessageObj *group = [[GroupMessageObj alloc] init];
            group.groupId = [message.groupID intValue];
            group.groupName = chatExtInfo[@"name"];
            group.groupPic = chatExtInfo[@"avatar"];
            group.groupLevel = chatExtInfo[@"gradeIcon"];
            group.groupType = ([message.groupID intValue] > 500000000)?1:0;
            self.groupMsg = group;
            
        }else{
            SingleMessageObj *single = [[SingleMessageObj alloc] init];
            single.otherUid = [message.userID intValue];
            single.otherUserName = chatExtInfo[@"name"];
            single.svipIcon = chatExtInfo[@"svipIcon"];
            single.role = [chatExtInfo[@"role"] intValue];
            single.sex = [chatExtInfo[@"sex"] intValue];
            single.age = [chatExtInfo[@"age"] intValue];
            single.otherUserAvater = chatExtInfo[@"avatar"];
            single.otherNobleMedalStr = chatExtInfo[@"nobleMedal"];
            self.singleMsg = single;
        }
        
    }
    
    
    
    ///消息发送人基本信息
    {
        int64_t UGID = [message.sender longLongValue];
        ImExtraInfo *info = [[IMSocketIns getIns] getExtraInfo:UGID];
        NSDictionary *sendExtInfo = info.extraInfo;
  
         
        SendMsgUserInfoObj *sendUserInfo = [[SendMsgUserInfoObj alloc] init];
        sendUserInfo.userId = UGID;
        sendUserInfo.avatar = sendExtInfo[@"avatar"];
        sendUserInfo.userName = sendExtInfo[@"name"];
        sendUserInfo.age = [sendExtInfo[@"age"] intValue];
        sendUserInfo.gender = [sendExtInfo[@"sex"] intValue];
        sendUserInfo.nobleFrameStr = sendExtInfo[@"nobleAvatarFrame"];
        sendUserInfo.nobleLevelStr = sendExtInfo[@"nobleGradeImg"];
        sendUserInfo.wealthLevelStr = sendExtInfo[@"wealthGradeImg"];
        sendUserInfo.nobleMedalStr = sendExtInfo[@"nobleMedal"];
        self.sendUserInfo = sendUserInfo;
    }
    
     
    self.imMessage = msg;
    self.messageTimeDate = message.timestamp;
    self.isOwner = message.isSelf;
    __block  NSDictionary *dic;
    if (message.elemType == V2TIM_ELEM_TYPE_CUSTOM) {
         dic = message.customElem.data.jsonValue;
        self.messageType = [dic[@"messageType"] integerValue];
    }else if(message.elemType == V2TIM_ELEM_TYPE_GROUP_TIPS){//群系统消息
        V2TIMGroupTipsElem *elem = message.groupTipsElem;
        self.messageType = IMMessageTypeForGroupTip;
        __block NSMutableString *notice = [NSMutableString string];
        if (elem.type == V2TIM_GROUP_TIPS_TYPE_JOIN ) {
            int64_t userId = [elem.memberList.firstObject.userID longLongValue];
            ImExtraInfo *info = [[IMSocketIns getIns] getExtraInfo:userId];
            [notice appendFormat: kLocalizationMsg(@"欢迎 ")];
            NSString *name = info.extraInfo[@"name"];
            if (name.length > 0) {
                [notice appendString:name];
            }
            [notice appendString:kLocalizationMsg(@" 加入群聊")];
            
        }else{
            [notice appendFormat: kLocalizationMsg(@"未知消息")];
        }
        dic =   @{
            @"messageContent":@{
                @"eventText":notice
            },
            @"messageType" : @"9"
        };
    }else{
       // NSLog(@"过滤文字####【IM警告】 ～～～～未知消息～～～～"));
    }
    [self showInfoWith:dic message:message];
      
} 
- (void)showInfoWith:(NSDictionary *)dic message:(V2TIMMessage*)message{
    NSDictionary *infoDict = [NSString dictionaryWithJsonString:dic[@"messageContent"]];
    self.customDict = infoDict;
     
    switch (self.messageType) {
        case IMMessageTypeForShopping: ///直播购物
        {
            self.shoppingMsg = [[ShopMessageModel alloc] initWidthDict:infoDict];
            self.msgTitle = kStringFormat(@"[%@]",self.shoppingMsg.orderTitle);
            {
                CGFloat shopHeight = [self.shoppingMsg getShopMessageHeight:self.isOwner] + 10 + 10;
                self.messageCellHeight = shopHeight + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeForPicture://图片
        {
            self.msgTitle = kLocalizationMsg(@"[图片]");
            self.picMsg = [[MessagePictureModel alloc] initWidthDict:infoDict];
            {
                self.messageCellHeight = 180 + (self.groupMsg?15:0);
            }
            
        }
            break;
        case IMMessageTypeForGift://礼物
        {
            self.msgTitle = kLocalizationMsg(@"[礼物]");
            self.giftMsg = [[SendGiftInfoModel alloc] initWidthDict:infoDict];
            {
                self.messageCellHeight = 75;
            }
        }
            break;
        case IMMessageTypeForAudio://语音
        {
            self.msgTitle = kLocalizationMsg(@"[音频]");
            self.voiceMsg = [[MessageVoiceModel alloc] initWidthDict:infoDict];
            {
                self.messageCellHeight = 60 + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeForVideo://视频
        {
            self.msgTitle = kLocalizationMsg(@"[视频]");
            {
                self.messageCellHeight = 180 + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeFor1v1Voice://1v1语音
        {
            self.msgTitle = kLocalizationMsg(@"[语音通话]");
            self.otoCallMsg = [[MessageOtoCallModel alloc] initWidthDict:infoDict isVideo:NO isOwner:self.isOwner];
            {
                self.messageCellHeight = 60 + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeFor1v1Video://1v1视频
        {
            self.msgTitle = kLocalizationMsg(@"[视频通话]");
            self.otoCallMsg = [[MessageOtoCallModel alloc] initWidthDict:infoDict isVideo:YES isOwner:self.isOwner];
            {
                self.messageCellHeight = 60 + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeForRedPack://红包
        case IMSystemMsgTypeForGroupRedPt:
        {
            self.msgTitle = kLocalizationMsg(@"[红包]");
            NSDictionary *extraInfo = message.localCustomData.jsonValue;
            self.redPacketMsg = [[MessageRedPacketModel alloc] initWidthDict:infoDict msgExtraInfo:extraInfo];
            {
                self.messageCellHeight = 130 + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeForShowOncePic://阅后即焚图片
        {
            self.msgTitle = kLocalizationMsg(@"[阅后即焚]");
            NSDictionary *extraInfo = message.localCustomData.jsonValue;
            self.oncePicMsg = [[MessageShowOncePicModel alloc] initWidthDict:infoDict msgExtraInfo:extraInfo];
            {
                self.messageCellHeight = 110 + (self.groupMsg?15:0);
            }
        }
            break;
        case IMMessageTypeForInviteOrder://邀约订单
        {
            self.inviteOrderMsg = [[InviteOrderModel alloc] initWidthDict:infoDict];
            self.msgTitle = [NSString stringWithFormat:@"[%@]",self.inviteOrderMsg.title];
            {
                CGFloat height = 30+10+20+10;
                CGFloat decLabelH = [self.inviteOrderMsg.content heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:kScreenWidth - 30];
                self.messageCellHeight = (height+decLabelH);
            }
        }
            break;
        case IMMessageTypeForText: ///纯文字
        {
            self.textMsg = [[MessageTextModel alloc] initWidthDict:infoDict];
            self.msgTitle = self.textMsg.contentStr;
            {
                CGSize textSize = [MessageChatModel getTextSizeWithContentString:self.textMsg.contentStr];
                textSize.height =  textSize.height + 12 +12 ;
                self.messageCellHeight = textSize.height + 10 + 6 + (self.groupMsg?15:0);
            }
        }
            break;
            
        case IMMessageTypeForGroupTip:// 群组提示
        {
            self.sysNoticeMsg = [[GroupSystemNormalMsgObj alloc] initWidthDict:infoDict];
            self.msgTitle = self.sysNoticeMsg.noticeStr;
            {
                CGFloat decLabelH = [self.sysNoticeMsg.noticeStr heightWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:kScreenWidth - 120];
                self.messageCellHeight = MAX(decLabelH, 30);
            }
        }
            break;
            
        case IMSystemMsgTypeForOpenRedPt:// 群组消息 - 收红包的消息
        {
            self.msgTitle = kLocalizationMsg(@"[红包]");
            self.sysOpenRedPtMsg = [[GroupOpenRedPacketMsgObj alloc] initWidthDict:infoDict];
            {
                CGFloat decLabelH = [self.sysOpenRedPtMsg.showContent heightWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:kScreenWidth - 40];
                self.messageCellHeight = decLabelH+20+10;
            }
        }
            break;
        case IMSystemMsgTypeForAskGift:// 群组消息 - 主播求赏的消息
        {
            self.msgTitle = kLocalizationMsg(@"[求赏]");
            self.askGiftMsg = [[MessageAskGiftModel alloc] initWidthDict:infoDict isOwner:self.isOwner];
            {
                CGFloat decLabelW = [self.askGiftMsg.showStr widthWithFont:[UIFont systemFontOfSize:16] constrainedToHeight:20];
                self.messageCellHeight = 80+10;
                self.messageWidth = MIN(decLabelW+20+60, kScreenWidth-100);
            }
        }
            break;
        case IMSystemMsgTypeForJoinFamily:// 群组消息 - 用户加入家族的消息
        {
            self.sysJoinFamilyMsg = [[GroupUserJoinFamilyObj alloc] initWidthDict:infoDict];
            self.msgTitle = [NSString stringWithFormat:kLocalizationMsg(@"%@加入家族"),self.sysJoinFamilyMsg.userName];
            {
                self.messageCellHeight = 70;
            }
        }
            break;
        case IMMessageTypeForunknown:
            self.msgTitle = kLocalizationMsg(@"未知消息");
            break;
        default:
            break;
    }
    if ([[ProjConfig shareInstence].baseConfig msgHasReadInfo] && message.isSelf && message.userID.length > 0) {
        self.messageCellHeight += 15;
    }
    
    ///是否为撤销的消息
    self.isCancelMsg = message.status == V2TIM_MSG_STATUS_LOCAL_REVOKED?YES:NO;
    [self setCancelMsgInfo];
}

///设置取消的消息内容
- (void)setCancelMsgInfo{
    if (self.isCancelMsg) {
        self.isCancelMsg = YES;
        self.msgTitle = kLocalizationMsg(@"[撤回]");
        {
            self.messageCellHeight = 40;
        }
    }
}
- (void)updateUserInfo:(int64_t)userId info:(ImExtraInfo *)info  resultBlock:(void(^)(NSDictionary *extInfoDic))resultBlock{
    NSMutableArray *groupArr = [[NSMutableArray alloc] init];
    NSMutableArray *userArr = [[NSMutableArray alloc] init];
    if (info) {
        if (![userArr containsObject:@(userId)]) {
            if (!info.extraInfoUpdateTime || ((info.extraInfoUpdateTime && [self judgeTime:info.extraInfoUpdateTime]))) {
                AppIdBOModel *idModel = [[AppIdBOModel alloc]init];
                idModel.id_field = userId;
                [userArr addObject:idModel];
            }
        }
    }else{
        AppIdBOModel *idModel = [[AppIdBOModel alloc]init];
        idModel.id_field = userId;
        [userArr addObject:idModel];
    }

    ///获取用户头像
    if (userArr.count > 0) {
        UserGroupIdDtoModel *model = [[UserGroupIdDtoModel alloc]init];
        model.groupIdList = groupArr;
        model.userIdList = userArr;
        [HttpApiChatMsgController getImExtraInfo1:model callback:^(int code, NSString *strMsg, NSArray<ImExtraInfoModel *> *arr) {
            if (code == 1 && arr.count) {
                NSMutableDictionary *extInfoDic = [[NSMutableDictionary alloc] init];
                for (ImExtraInfoModel *userInfoM in arr) {
                    if (userInfoM.name.length || userInfoM.avatar.length) {
                        NSDictionary *dict = [userInfoM modelToJSONObject];
                        [extInfoDic setObject:dict forKey:@(userInfoM.UGID)];
                        [[IMSocketIns getIns] setExtraInfo:userInfoM.UGID ditExtraInfo:dict];
                    }
                }
                resultBlock?resultBlock([extInfoDic copy]):nil;
            }else{
                resultBlock?resultBlock(@{}):nil;
            }
        }];
        
    }else{
        resultBlock?resultBlock(@{} ):nil;
    }
}

///判断时间和现在时间是否想查两个小时
- (BOOL)judgeTime:(NSDate *)updateDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    // NSCalendarUnit 枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:updateDate toDate:currentDate options:0];
    if (!cmps.year && !cmps.month && !cmps.day && !cmps.hour) {
        if (cmps.minute<30) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
+ (CGSize)getTextSizeWithContentString:(NSString *)contentString {
    CGSize maxSize = CGSizeMake(kScreenWidth - 100, MAXFLOAT);
    UIFont *font = [UIFont systemFontOfSize:16];
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    CGSize realSize = [contentString boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
    if (contentString) {
        UILabel *imLabel = [[UILabel alloc]init];
        imLabel.font = font;
        imLabel.numberOfLines = 0;
        imLabel.size = maxSize;
        //匹配表情文字
        NSString *pattern = @"\\[\\w+\\]";
        NSArray *resultArr =   [self machesWithPattern:pattern andStr:contentString];
        if(resultArr) {
            NSUInteger lengthDetail = 0;
            NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:contentString];
            //遍历所有的result 取出range
            for (NSTextCheckingResult *result in resultArr) {
                //取出图片名
                NSString *imageName =   [contentString substringWithRange:NSMakeRange(result.range.location, result.range.length)];
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                NSString *imgPath= [[[NSBundle mainBundle] pathForResource:@"customEmoji" ofType:@"bundle"] stringByAppendingPathComponent:imageName];
                UIImage *emojiImage = [UIImage imageNamed:imgPath];
                NSAttributedString *imageString;
                if (emojiImage) {
                    attach.image = emojiImage;
                    attach.bounds = CGRectMake(0, -5, 21, 21);
                    imageString =   [NSAttributedString attributedStringWithAttachment:attach];
                }else{
                    imageString =   [[NSMutableAttributedString alloc]initWithString:imageName];
                }
                NSUInteger length = attstr.length;
                NSRange newRange = NSMakeRange(result.range.location - lengthDetail, result.range.length);
                [attstr replaceCharactersInRange:newRange withAttributedString:imageString];
                lengthDetail += length - attstr.length;
            }
            imLabel.attributedText = attstr;
            [imLabel sizeToFit];
            realSize = imLabel.frame.size;
            
        }
    }
    
    CGSize imgSize =realSize;
    //    imgSize.height=realSize.height ;
    //    imgSize.width=realSize.width+2*15;
    
    
    return imgSize;
}


+ (NSArray <NSTextCheckingResult *> *)machesWithPattern:(NSString *)pattern  andStr:(NSString *)str {
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
       // NSLog(@"过滤文字正则表达式创建失败"));
        return nil;
    }
    return [expression matchesInString:str options:0 range:NSMakeRange(0, str.length)];
}



///获得显示时间的高度
- (CGFloat)messageTimeHeight{
    return self.isShowTime?30.0:0.0;
}


@end
