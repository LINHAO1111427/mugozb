//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播间简单消息展示
 */
@interface ApiSimpleMsgRoomModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
消息类型 1:进场消息 2:退场消息 3:礼物消息 4:点亮 5:红包 6:禁言解禁消息 7:设置取消管理员 8:踢人消息 9:购买守护 10:关注和取消关注 11:文字聊天消息 12:主播离开回来消息 13:系统消息 14:弹幕消息 15:骰子 16:警告消息 17:老虎机 18:麦序机
 */
@property (nonatomic, assign) int type;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
主播头像
 */
@property (nonatomic, copy) NSString * anchorAvatar;

	/**
主播姓名
 */
@property (nonatomic, copy) NSString * anchorName;

	/**
消息内容
 */
@property (nonatomic, copy) NSString * content;

	/**
守护类型 0:没有守护 1:普通 2:尊贵
 */
@property (nonatomic, assign) int guardType;

	/**
是否是粉丝 1:是粉丝 0:不是粉丝
 */
@property (nonatomic, assign) int isFans;

	/**
靓号
 */
@property (nonatomic, copy) NSString * goodnum;

	/**
用户的真实角色
 */
@property (nonatomic, assign) int role;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
用户等级
 */
@property (nonatomic, assign) int userGrade;

	/**
财富等级
 */
@property (nonatomic, assign) int wealthGrade;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
用户等级图片
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
礼物id
 */
@property (nonatomic, assign) int64_t giftId;

	/**
礼物类型 0:普通礼物 1:粉丝团(豪华礼物) 2:守护(专属礼物) 3:贵族礼物(特殊礼物) 4:签到礼物 5:幸运礼物
 */
@property (nonatomic, assign) int giftType;

	/**
礼物图标
 */
@property (nonatomic, copy) NSString * giftIcon;

	/**
礼物名称
 */
@property (nonatomic, copy) NSString * giftName;

	/**
礼物数量
 */
@property (nonatomic, assign) int giftNumber;

	/**
是否字体变色 1:变色 0:不变色
 */
@property (nonatomic, assign) int fontDiscoloration;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
app使用，后台不管
 */
@property (nonatomic, copy) NSString * translation;

 +(NSMutableArray<ApiSimpleMsgRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSimpleMsgRoomModel*>*)list;

 +(ApiSimpleMsgRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSimpleMsgRoomModel*) source target:(ApiSimpleMsgRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
