//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播大厅
 */
@interface LiveBeanModel : NSObject 


	/**
正在进行的游戏
 */
@property (nonatomic, copy) NSString * game;

	/**
直播位置
 */
@property (nonatomic, copy) NSString * distance;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

	/**
游戏状态
 */
@property (nonatomic, assign) int gameAction;

	/**
直播间标题
 */
@property (nonatomic, copy) NSString * title;

	/**
直播类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 
 */
@property (nonatomic, assign) int type;

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
用户等级
 */
@property (nonatomic, copy) NSString * userLevel;

	/**
流名
 */
@property (nonatomic, copy) NSString * stream;

	/**
用户昵称
 */
@property (nonatomic, copy) NSString * nickname;

	/**
直播间人数
 */
@property (nonatomic, assign) int nums;

	/**
类型值
 */
@property (nonatomic, copy) NSString * typeVal;

	/**
直播状态 1:直播中 0:关播
 */
@property (nonatomic, assign) int islive;

	/**
门票房间是否需要付费 0:不需要付费 1:需要付费
 */
@property (nonatomic, assign) int isPay;

	/**
直播性别
 */
@property (nonatomic, assign) int sex;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
主播等级
 */
@property (nonatomic, copy) NSString * anchorLevel;

	/**
播流地址
 */
@property (nonatomic, copy) NSString * pull;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
主播的靓号
 */
@property (nonatomic, copy) NSString * goodnum;

 +(NSMutableArray<LiveBeanModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveBeanModel*>*)list;

 +(LiveBeanModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveBeanModel*) source target:(LiveBeanModel*)target;

@end

NS_ASSUME_NONNULL_END
