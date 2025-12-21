//
//  MessageContentObj.h
//  Message
//
//  Created by klc_sl on 2021/8/6.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <LibProjModel/OneRedPacketVOModel.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark   - base -
@interface MessageContentObj : NSObject

- (instancetype)initWidthDict:(NSDictionary *)dict;

@end






#pragma mark   - 购物订单 -
///购物订单
@interface ShopMessageModel : MessageContentObj

@property (nonatomic, copy)NSString *orderTitle;//订单类型标题

@property (nonatomic, assign)int productNum;//商品数量
@property (nonatomic, assign)int refundType;//退款类型
@property (nonatomic, assign)int orderStatus;//订单状态
@property (nonatomic, assign)double totalAmout;//总金额

@property (nonatomic, copy)NSString *tips;//提示
@property (nonatomic, assign)NSInteger orderId;//订单id
@property (nonatomic, assign)NSInteger buyerId;//买家userid
@property (nonatomic, assign)NSInteger sellerId;//卖家userid

@property (nonatomic, copy)NSString *productName;//商品名称
@property (nonatomic, copy)NSString *productImage;//商品图片

@property (nonatomic, copy)NSString *name;//收货人姓名
@property (nonatomic, copy)NSString *address;//收货人地址
@property (nonatomic, copy)NSString *phoneNum;//收货人电话
 
@property (nonatomic, copy)NSString *reason;//审核不通过原因
@property (nonatomic, assign)NSString *refundTime;//退款到账时间
@property (nonatomic, copy)NSString *refundNotes;//申请退款的原因
@property (nonatomic, copy)NSString *refundNotesImages;//申请退款的凭证图片

@property (nonatomic, assign)CGFloat viewHeight; ///整个视图height

- (CGFloat)getShopMessageHeight:(BOOL)isOwner;

@end






#pragma mark   - 寻觅订单 -
///寻觅订单
@interface InviteOrderModel : MessageContentObj
///订单ID
@property (nonatomic, copy)NSNumber *orderId;
///标题
@property (nonatomic, copy)NSString *title;
///内容
@property (nonatomic, copy)NSString *content;

@end







#pragma mark   - 送礼的信息 -
///送礼的信息
@interface SendGiftInfoModel : MessageContentObj
///礼物图标
@property (nonatomic, copy) NSString *giftIcon;
///发送人的头像
@property (nonatomic, copy) NSString *ownIcon;
///接受人的头像
@property (nonatomic, copy) NSString *otherIcon;
///发送人的Uid
@property (nonatomic, assign) int64_t ownUid;
///接受人的Uid
@property (nonatomic, assign) int64_t otherUid;
///送礼的个数
@property (nonatomic, assign)int number;

@end



#pragma mark   - 文字内容 -
@interface MessageTextModel : MessageContentObj
///文字
@property (nonatomic, copy) NSString *contentStr;
///是否置顶
@property (nonatomic, assign) BOOL isTop;
///留着备用
@property (nonatomic, copy) NSString *remark;

@end


#pragma mark   - 发送语音内容 -
@interface MessageVoiceModel : MessageContentObj
///语音时长
@property (nonatomic, copy) NSString *audioTimeStr;
///录音Url
@property (nonatomic, copy) NSString *recordUrl;


@end


#pragma mark   - oto视频聊天&oto语音聊天 -
@interface MessageOtoCallModel : MessageContentObj

@property (nonatomic, assign)BOOL isVideo;
///status   0- 接通了  time  时长 1 - 取消  2 - 被挂断   3 - 未接
@property (nonatomic, assign) int otoStatus;
///通话时间
@property (nonatomic, copy) NSString *otoTime;
///通话显示的提示文字
@property (nonatomic, copy) NSString *otoStatusStr;

- (instancetype)initWidthDict:(NSDictionary *)dict isVideo:(BOOL)isVideo isOwner:(BOOL)isOwner;

@end

#pragma mark   - 图片消息 -
@interface MessagePictureModel : MessageContentObj
///图片地址
@property (nonatomic, copy) NSString *picUrlStr;

@end

#pragma mark   - 红包消息 -
@interface MessageRedPacketModel : MessageContentObj

///status是否领取到了 0:未领取 1:领到了(表示本次打开红包) 2:已经领过了 3:红包领取完了 4：红包过期了
@property (nonatomic, assign)int redPtStatus;

@property (nonatomic, strong)OneRedPacketVOModel *redPacket;

- (instancetype)initWidthDict:(NSDictionary *)dict msgExtraInfo:(NSDictionary *)extraInfo;


@end

#pragma mark   - 阅后即焚 -
@interface MessageShowOncePicModel : MessageContentObj
///阅读状态 0未读   1 已读
@property (nonatomic, assign)int readStatus;
///图片地址
@property (nonatomic, copy) NSString *picUrlStr;

- (instancetype)initWidthDict:(NSDictionary *)dict msgExtraInfo:(NSDictionary *)extraInfo;

@end



#pragma mark   - 群组提示消息 -
@interface MessageGroupTipModel : MessageContentObj
///提示消息
@property (nonatomic, copy) NSString *tipTextStr;

@end


#pragma mark   - 用户求赏消息 -
@interface MessageAskGiftModel : MessageContentObj
///礼物ID
@property (nonatomic, assign) int64_t giftId;
///礼物类型
@property (nonatomic, assign) int giftType;
///礼物图标
@property (nonatomic, copy) NSString *giftIcon;
///礼物名称
@property (nonatomic, copy) NSString *giftName;
///私信显示的文字
@property (nonatomic, copy) NSString *showStr;

- (instancetype)initWidthDict:(NSDictionary *)dict isOwner:(BOOL)isOwner;

@end





/// 群组普通消息
@interface GroupSystemNormalMsgObj : MessageContentObj
///通知消息
@property (nonatomic, copy) NSString *noticeStr;

@end


///用户开启红包消息
@interface GroupOpenRedPacketMsgObj : MessageContentObj

///发红包uid
@property (nonatomic, assign) int64_t sendUserId;
///发红包人名称
@property (nonatomic, copy) NSString *sendUserName;
///领红包人的Uid
@property (nonatomic, assign) int64_t toUserId;
///领红包人的名称
@property (nonatomic, copy) NSString *toUserName;
///领到金额
@property (nonatomic, assign) double unitPrice;
///显示的文字内容
@property (nonatomic, copy) NSString *showContent;
///发送人姓名的位置
@property (nonatomic) NSRange sendNameRg;

@end



///用户加入群聊消息
@interface GroupUserJoinFamilyObj : MessageContentObj
///加入群聊的用户ID
@property (nonatomic, assign) int64_t userId;
///加入群聊的用户名
@property (nonatomic, copy) NSString *userName;
///加入群聊的用户头像
@property (nonatomic, copy) NSString *userAvater;

@end





NS_ASSUME_NONNULL_END
