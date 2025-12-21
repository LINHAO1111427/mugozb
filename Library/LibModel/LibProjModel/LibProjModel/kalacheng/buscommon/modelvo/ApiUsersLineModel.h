//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
在线用户数据
 */
@interface ApiUsersLineModel : NSObject 


	/**
出生日期
 */
@property (nonatomic, copy) NSString * birthday;

	/**
角色id
 */
@property (nonatomic, assign) int role;

	/**
距离
 */
@property (nonatomic, copy) NSString * distance;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
用户签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

	/**
用户在线状态 0:离线 1:在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
用户等级图片
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
视频通话时间金币/min
 */
@property (nonatomic, assign) double videoCoin;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
直播间名称
 */
@property (nonatomic, copy) NSString * title;

	/**
直播类型(1:多人视频 2:多人语音)
 */
@property (nonatomic, assign) int type;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户设置的在线状态 0:在线 1:忙碌 2:离开 3:通话中
 */
@property (nonatomic, assign) int userSetOnlineStatus;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
类型描述
 */
@property (nonatomic, copy) NSString * typeDec;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
星座
 */
@property (nonatomic, copy) NSString * constellation;

	/**
离线时间
 */
@property (nonatomic, copy) NSString * offLineTime;

	/**
语音通话时间金币/min
 */
@property (nonatomic, assign) double voiceCoin;

	/**
视频直播状态：0:未进行直播 1:直播中的主播 2:直播中的观众
 */
@property (nonatomic, assign) int liveStatus;

	/**
身高（CM）
 */
@property (nonatomic, assign) int height;

	/**
币种类型
 */
@property (nonatomic, copy) NSString * coinType;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
类型值
 */
@property (nonatomic, copy) NSString * typeVal;

	/**
地址
 */
@property (nonatomic, copy) NSString * address;

	/**
隐藏距离 0:不隐藏 1:隐藏
 */
@property (nonatomic, assign) int hideDistance;

	/**
门票房间是否需要付费 0:不需要付费 1:需要付费
 */
@property (nonatomic, assign) int isPay;

	/**
svip 图标
 */
@property (nonatomic, copy) NSString * svipIcon;

	/**
性别；0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;

	/**
体重（KG）
 */
@property (nonatomic, assign) double weight;

	/**
隐藏位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int whetherEnablePositioningShow;

	/**
头像图片
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户资料图片(因为只是展示,所以保持不变)， 英文逗号隔开
 */
@property (nonatomic, copy) NSString * portrait;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
直播标识(房间号)
 */
@property (nonatomic, copy) NSString * showid;

	/**
离线时间Data
 */
@property (nonatomic,copy) NSDate * offLineTimeData;

	/**
直播类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 */
@property (nonatomic, assign) int sourceType;

	/**
离线时间
 */
@property (nonatomic,copy) NSDate * lastOffLineTime;

	/**
用户是否开通svip 1:是 0:否
 */
@property (nonatomic, assign) int isSvip;

	/**
用户年龄
 */
@property (nonatomic, assign) int age;

	/**
用户金币
 */
@property (nonatomic, assign) double coin;

	/**
聊场是否显示金币 1:显示 0:不显示
 */
@property (nonatomic, assign) int isSayCoin;

	/**
直播状态 0:直播结束 1:直播中
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ApiUsersLineModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersLineModel*>*)list;

 +(ApiUsersLineModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsersLineModel*) source target:(ApiUsersLineModel*)target;

@end

NS_ASSUME_NONNULL_END
