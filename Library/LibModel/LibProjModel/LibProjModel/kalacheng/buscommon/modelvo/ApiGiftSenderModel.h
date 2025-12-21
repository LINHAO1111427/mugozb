//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserBasicInfoModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP发礼物响应
 */
@interface ApiGiftSenderModel : NSObject 


	/**
礼物图标
 */
@property (nonatomic, copy) NSString * gifticon;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
礼物名称
 */
@property (nonatomic, copy) NSString * giftName;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
背包礼物总价值
 */
@property (nonatomic, assign) double backpackCoinSum;

	/**
类型 0:普通礼物 1:粉丝团(豪华礼物) 2:守护(专属礼物) 3:贵族礼物(特殊礼物) 4:背包礼物 5:幸运礼物
 */
@property (nonatomic, assign) int type;

	/**
主播姓名
 */
@property (nonatomic, copy) NSString * anchorName;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
连送次数
 */
@property (nonatomic, assign) int continuousNumber;

	/**
礼物id
 */
@property (nonatomic, assign) int64_t giftId;

	/**
直播间观众列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUserBasicInfoModel*>* userList;

	/**
动图时长
 */
@property (nonatomic, assign)  float swftime;

	/**
主播头像
 */
@property (nonatomic, copy) NSString * anchorAvatar;

	/**
用户余额
 */
@property (nonatomic, assign) double userCoin;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
中奖金币数量
 */
@property (nonatomic, assign) double winCoin;

	/**
礼物动态
 */
@property (nonatomic, copy) NSString * giftswf;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
是否有送礼特效特权 0没有 1有
 */
@property (nonatomic, assign) int sendGiftPrivilege;

	/**
用户余额(积分)
 */
@property (nonatomic, assign) double userOverScore;

	/**
魅力值
 */
@property (nonatomic, assign) double votes;

	/**
送礼物的类型
 */
@property (nonatomic, assign) int sendGiftType;

	/**
礼物个数
 */
@property (nonatomic, assign) int giftNumber;

 +(NSMutableArray<ApiGiftSenderModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGiftSenderModel*>*)list;

 +(ApiGiftSenderModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiGiftSenderModel*) source target:(ApiGiftSenderModel*)target;

@end

NS_ASSUME_NONNULL_END
