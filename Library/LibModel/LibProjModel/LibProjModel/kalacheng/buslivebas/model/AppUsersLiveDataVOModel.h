//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
直播数据VO
 */
@interface AppUsersLiveDataVOModel : NSObject 


	/**
收到礼物个数
 */
@property (nonatomic, assign) int addGiftNumber;

	/**
打赏人数
 */
@property (nonatomic, assign) int rewardNumber;

	/**
封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态)
 */
@property (nonatomic, assign) int liveType;

	/**
观众人数
 */
@property (nonatomic, assign) int audienceNumber;

	/**
直播间名称
 */
@property (nonatomic, copy) NSString * title;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
类型描述
 */
@property (nonatomic, copy) NSString * typeDec;

	/**
当前直播次数
 */
@property (nonatomic, assign) int number;

	/**
主播id
 */
@property (nonatomic, assign) int64_t uid;

	/**
加入粉丝团人数
 */
@property (nonatomic, assign) int addFansGroup;

	/**
直播时长(单位秒)
 */
@property (nonatomic, assign) int64_t liveTime;

	/**
开始时间
 */
@property (nonatomic,copy) NSDate * startTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
主播开播地址
 */
@property (nonatomic, copy) NSString * addr;

	/**
总收益
 */
@property (nonatomic, assign) double profit;

	/**
房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
类型值
 */
@property (nonatomic, copy) NSString * typeVal;

	/**
门票房间是否需要付费0不需要付费1需要付费
 */
@property (nonatomic, assign) int isPay;

	/**
新增关注人数
 */
@property (nonatomic, assign) int addFollow;

	/**
流地址
 */
@property (nonatomic, copy) NSString * rtmpUrl;

	/**
直播标识(房间号)
 */
@property (nonatomic, copy) NSString * showid;

	/**
结束时间
 */
@property (nonatomic,copy) NSDate * endTime;

	/**
付费/计时房间金额
 */
@property (nonatomic, assign) double coin;

	/**
直播状态 0:直播结束 1:直播中
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppUsersLiveDataVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersLiveDataVOModel*>*)list;

 +(AppUsersLiveDataVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUsersLiveDataVOModel*) source target:(AppUsersLiveDataVOModel*)target;

@end

NS_ASSUME_NONNULL_END
