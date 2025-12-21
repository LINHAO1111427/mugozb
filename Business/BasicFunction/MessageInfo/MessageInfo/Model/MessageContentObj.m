//
//  MessageContentObj.m
//  Message
//
//  Created by klc_sl on 2021/8/6.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageContentObj.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import "ShopChatMessageView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCAppConfig.h>

@implementation MessageContentObj

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
    }
    return self;
}


@end



@implementation ShopMessageModel

- (instancetype)initWidthDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        int orderStatus  = [dict[@"orderStatus"] intValue];
        int productNum  = [dict[@"productNum"] intValue];
        int refundType  = [dict[@"refundType"] intValue];
        double totalAmout  = [dict[@"totalAmount"] doubleValue];
        NSString * tips  = dict[@"tips"];
        NSInteger orderId  = [dict[@"orderId"] integerValue];
        NSInteger buyerId  = [dict[@"buyerId"] integerValue];
        NSInteger sellerId = [dict[@"sellerId"] integerValue];
        NSString * productName  = dict[@"productName"];
        NSString * productImage  = dict[@"productImage"];
        NSString * name  = dict[@"name"];
        NSString * address  = dict[@"address"];
        NSString * phoneNum  = dict[@"phoneNum"];
        NSString * reason  = dict[@"reason"];
        NSString * refundTime  = dict[@"refundTime"];
        NSString * refundNotes  = dict[@"refundNotes"];
        NSString * refundNotesImages  = dict[@"refundNotesImages"];
        
        _orderStatus = orderStatus > 0?orderStatus:1;
        _productNum = productNum;
        _refundType = refundType;
        _totalAmout = totalAmout;
        _tips = tips.length > 0?tips:@"";
        _orderId = orderId > 0?orderId:0;
        _buyerId = buyerId;
        _sellerId = sellerId;
        _productName = productName.length > 0?productName:@"";
        _productImage = productImage.length > 0?productImage:@"";
        _name = name.length > 0?name:@"";
        _address = address.length > 0?address:@"";
        _phoneNum = phoneNum.length > 0?phoneNum:@"";
        _reason = reason.length > 0?reason:@"";
        _refundTime = refundTime.length > 0?refundTime:@"";
        _refundNotes = refundNotes.length > 0?refundNotes:@"";
        _refundNotesImages = refundNotesImages.length > 0?refundNotesImages:@"";
        
        NSString *title = kLocalizationMsg(@"订单信息");
        switch (_orderStatus) {
            case 1: //待卖家发货
                title = kLocalizationMsg(@"下单提醒");
                break;
            case 2: //待买家收货
                title = kLocalizationMsg(@"您的订单已发货");
                break;
            case 3: //申请退款待审核
                title = kLocalizationMsg(@"退款申请");
                break;
            case 4: //申请退款审核失败
                title = kLocalizationMsg(@"您的退款申请未通过");
                break;
            case 5: //待买家发货
                title = kLocalizationMsg(@"您的退款申请审核已通过");
                break;
            case 6: //待卖家收货
                title = kLocalizationMsg(@"退款收货提醒");
                break;
            case 7: //退款完成
                title = kLocalizationMsg(@"您的退款已到账");
                break;
            case 8://催单
                title = kLocalizationMsg(@"提醒发货");
                break;
            case 9://卖家确认收货
                title = kLocalizationMsg(@"退款货物已签收");
                break;
            default:{
            }
        }
        self.orderTitle = title;
    }
    return self;
}

- (CGFloat)getShopMessageHeight:(BOOL)isOwner{
    self.viewHeight = [ShopChatMessageView getViewHeight:self isOwner:isOwner];
    return self.viewHeight;
}


@end

@implementation InviteOrderModel

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _orderId = @([dict[@"promiseOrderId"] longLongValue]);
        
        if ([dict[@"userId"] longLongValue] == [ProjConfig userId]) {
            _content = dict[@"userContext"];
            _title = dict[@"userTitle"];
        }
        if ([dict[@"anchorId"] longLongValue] == [ProjConfig userId]) {
            _content = dict[@"anchorContext"];
            _title = dict[@"anchorTitle"];
        }
    }
    return self;
}

@end


@implementation SendGiftInfoModel

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _giftIcon = dict[@"giftIcon"];
        _number = [dict[@"giftCount"] intValue];
        _ownIcon = dict[@"ownIcon"];
        _otherIcon = dict[@"otherIcon"];
        _ownUid = [dict[@"ownUid"] longLongValue];
        _otherUid = [dict[@"otherUid"] longLongValue];
    }
    return self;
}

@end





#pragma mark   - 文字内容 -
@implementation MessageTextModel

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _contentStr = dict[@"txt"];
        _isTop = [dict[@"isTop"] boolValue];
    }
    return self;
}

@end


#pragma mark   - 发送语音内容 -
@implementation MessageVoiceModel

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _audioTimeStr = dict[@"time"];
        _recordUrl = dict[@"recordUrl"];
    }
    return self;
}

@end


#pragma mark   - oto视频聊天&oto语音聊天 -
@implementation MessageOtoCallModel

- (instancetype)initWidthDict:(NSDictionary *)dict isVideo:(BOOL)isVideo isOwner:(BOOL)isOwner {
    self = [super init];
    if (self) {
        _isVideo = isVideo;
        _otoStatus = [dict[@"status"] intValue];
        _otoTime = dict[@"time"];
        
        NSString *contentStr = @"";
        // status   0- 接通了 time通话时长  1 - 自己取消  2 - 被对方挂断   3 - 对方未接
        if (isOwner) {
            switch (_otoStatus) {
                case 0: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 通话时长 %@"),_otoTime];
                    break;
                case 1: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 已取消")];
                    break;
                case 2: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 已被挂断")];
                    break;
                case 3: contentStr = kLocalizationMsg(@" 对方无应答");
                    break;
                default:
                    break;
            }
        }else{
            switch (_otoStatus) {
                case 0: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 通话时长 %@"),_otoTime];
                    break;
                case 1: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 对方已取消")];
                    break;
                case 2: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 已拒绝")];
                    break;
                case 3: contentStr = [NSString stringWithFormat:kLocalizationMsg(@" 已被取消")];
                    break;
                default:
                    break;
            }
        }
        _otoStatusStr = contentStr;
    }
    return self;
}

@end


#pragma mark   - 图片消息 -
@implementation MessagePictureModel

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _picUrlStr = dict[@"picUrlStr"];
    }
    return self;
}

@end


#pragma mark   - 红包消息 -
@implementation MessageRedPacketModel

- (instancetype)initWidthDict:(NSDictionary *)dict msgExtraInfo:(NSDictionary *)extraInfo{
    self = [super init];
    if (self) {
        _redPacket = [OneRedPacketVOModel getFromDict:dict];
        _redPtStatus = [extraInfo[@"redPtStatus"] intValue];
    }
    return self;
}

@end

#pragma mark   - 阅后即焚 -
@implementation MessageShowOncePicModel

- (instancetype)initWidthDict:(NSDictionary *)dict msgExtraInfo:(NSDictionary *)extraInfo{
    self = [super init];
    if (self) {
        _picUrlStr = dict[@"picUrlStr"];
        _readStatus = [extraInfo[@"readStatus"] intValue]; 
    }
    return self;
}

@end


@implementation MessageGroupTipModel

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _tipTextStr = dict[@"eventText"];
    }
    return self;
}

@end


@implementation MessageAskGiftModel

- (instancetype)initWidthDict:(NSDictionary *)dict isOwner:(BOOL)isOwner {
    self = [super initWidthDict:dict];
    if (self) {
        _giftIcon = dict[@"giftIcon"];
        _giftId = [dict[@"giftId"] longLongValue];
        _giftName = dict[@"giftName"];
        _giftType = [dict[@"giftType"] intValue];
        if (isOwner) {
            _showStr = kStringFormat(kLocalizationMsg(@"向对方求赏 %@ 礼物"),self.giftName);
        }else{
            _showStr = kStringFormat(kLocalizationMsg(@"对方向你求赏 %@ 礼物"),self.giftName);
        }
    }
    return self;
}

@end




@implementation GroupSystemNormalMsgObj

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _noticeStr = dict[@"eventText"];
    }
    return self;
}

@end




@implementation GroupOpenRedPacketMsgObj

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _sendUserId = [dict[@"sendUserId"] longLongValue];
        _sendUserName = dict[@"sendUserName"];
        _toUserId = [dict[@"toUserId"] longLongValue];
        _toUserName = dict[@"toUserName"];
        _unitPrice = [dict[@"unitPrice"] doubleValue];
        _showContent = [NSString stringWithFormat:kLocalizationMsg(@"%@抢到了%@红包雨中的%.0lf%@"),_toUserName,_sendUserName,_unitPrice,kUnitStr];
        _sendNameRg = NSMakeRange(_toUserName.length+3, _sendUserName.length);
    }
    return self;
}

@end




@implementation GroupUserJoinFamilyObj

- (instancetype)initWidthDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _userName = dict[@"userName"];
        _userId = [dict[@"userId"] longLongValue];
    }
    return self;
}

@end

