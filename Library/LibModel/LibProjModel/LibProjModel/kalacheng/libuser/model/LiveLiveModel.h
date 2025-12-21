//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播间表
 */
@interface LiveLiveModel : NSObject 


	/**
是否推荐 0:不推荐 1:推荐中
 */
@property (nonatomic, assign) int isRecommend;

	/**
开播时间
 */
@property (nonatomic,copy) NSDate * starttime;

	/**
游戏类型
 */
@property (nonatomic, assign) int gameAction;

	/**
房间状态 1：开启 0：关闭
 */
@property (nonatomic, assign) int roomStatus;

	/**
直播购房间标签
 */
@property (nonatomic, copy) NSString * shopRoomLabel;

	/**
省份
 */
@property (nonatomic, copy) NSString * province;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
纬度
 */
@property (nonatomic, assign) double lat;

	/**
房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
连麦开关 0：关 1：开
 */
@property (nonatomic, assign) int ismic;

	/**
直播状态 1:直播中 0:关播
 */
@property (nonatomic, assign) int islive;

	/**
标签名
 */
@property (nonatomic, copy) NSString * tabName;

	/**
经度
 */
@property (nonatomic, assign) double lng;

	/**
是否有直播购 0:没有直播购 1:有直播购
 */
@property (nonatomic, assign) int liveFunction;

	/**
权重排序字段
 */
@property (nonatomic, assign) int sort;

	/**
热门分类ID
 */
@property (nonatomic, assign) int64_t hotSortId;

	/**
房间类型值
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
封面图审核人
 */
@property (nonatomic, copy) NSString * thumbAuditBy;

	/**
二级广告id8
 */
@property (nonatomic, assign) int64_t roomAdsId8;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
二级广告id3
 */
@property (nonatomic, assign) int64_t roomAdsId3;

	/**
二级广告id2
 */
@property (nonatomic, assign) int64_t roomAdsId2;

	/**
是否假视频 0:直播 1:视频(假视频)
 */
@property (nonatomic, assign) int isvideo;

	/**
二级广告id1
 */
@property (nonatomic, assign) int64_t roomAdsId1;

	/**
封面审核时间
 */
@property (nonatomic,copy) NSDate * thumbAuditTime;

	/**
一级广告id
 */
@property (nonatomic, assign) int64_t roomAdsId0;

	/**
二级广告id7
 */
@property (nonatomic, assign) int64_t roomAdsId7;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

	/**
二级广告id6
 */
@property (nonatomic, assign) int64_t roomAdsId6;

	/**
二级广告id5
 */
@property (nonatomic, assign) int64_t roomAdsId5;

	/**
二级广告id4
 */
@property (nonatomic, assign) int64_t roomAdsId4;

	/**
封面图未通过原因
 */
@property (nonatomic, copy) NSString * thumbAuditReason;

	/**
直播间广告模板id
 */
@property (nonatomic, assign) int64_t adsTemplateId;

	/**
直播横幅
 */
@property (nonatomic, copy) NSString * shopLiveBanner;

	/**
流名
 */
@property (nonatomic, copy) NSString * stream;

	/**
用户昵称
 */
@property (nonatomic, copy) NSString * nickname;

	/**
后台页面使用，不用管
 */
@property (nonatomic, assign) int64_t importTemplateId;

	/**
标签样式
 */
@property (nonatomic, copy) NSString * tabStyle;

	/**
封面审核状态 0：初始状态 1未审核 2已通过 3未通过
 */
@property (nonatomic, assign) int thumbState;

	/**
平台庄家余额
 */
@property (nonatomic, assign) int bankerCoin;

	/**
频道ID
 */
@property (nonatomic, assign) int64_t channelId;

	/**
公告
 */
@property (nonatomic, copy) NSString * notice;

	/**
使用直播间广告模板 0：不启用 1:启用
 */
@property (nonatomic, assign) int isEnableAdsTemplate;

	/**
详细地址
 */
@property (nonatomic, copy) NSString * address;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
是否演示账号： 0否  1是
 */
@property (nonatomic, assign) int demoAccount;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
房间锁 1:上锁了 0:未上锁
 */
@property (nonatomic, assign) int liveLockStatus;

	/**
热门礼物总额
 */
@property (nonatomic, assign) int hotvotes;

	/**
播流地址
 */
@property (nonatomic, copy) NSString * pull;

	/**
直播标识
 */
@property (nonatomic, copy) NSString * showid;

	/**
靓号
 */
@property (nonatomic, copy) NSString * goodnum;

 +(NSMutableArray<LiveLiveModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveLiveModel*>*)list;

 +(LiveLiveModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveLiveModel*) source target:(LiveLiveModel*)target;

@end

NS_ASSUME_NONNULL_END
