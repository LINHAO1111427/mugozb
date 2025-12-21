//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP遇见用户端相应
 */
@interface ApiCfgPayCallOneVsOneModel : NSObject 


	/**
兴趣(json)
 */
@property (nonatomic, copy) NSString * tabIdList;

	/**
展示声音 
 */
@property (nonatomic, copy) NSString * voice;

	/**
隐藏距离 0:不隐藏 1:隐藏
 */
@property (nonatomic, assign) int hideDistance;

	/**
距离
 */
@property (nonatomic, copy) NSString * distance;

	/**
经度
 */
@property (nonatomic, assign) double lng;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
一对一打开状态0：默认，不打开  1：打开 
 */
@property (nonatomic, assign) int openState;

	/**
视频通话时间金币/min
 */
@property (nonatomic, assign) double videoCoin;

	/**
展示视频封面
 */
@property (nonatomic, copy) NSString * videoImg;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * liveThumb;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * updateTime;

	/**
隐藏位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int whetherEnablePositioningShow;

	/**
展示视频
 */
@property (nonatomic, copy) NSString * video;

	/**
用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID 
 */
@property (nonatomic, assign) int64_t userId;

	/**
省份
 */
@property (nonatomic, copy) NSString * province;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
主播被邀请的状态 0.待邀请 1.邀请中
 */
@property (nonatomic, assign) int invitedFlag;

	/**
语音通话时间金币/min
 */
@property (nonatomic, assign) double voiceCoin;

	/**
id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
纬度
 */
@property (nonatomic, assign) double lat;

	/**
备注 
 */
@property (nonatomic, copy) NSString * remarks;

 +(NSMutableArray<ApiCfgPayCallOneVsOneModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCfgPayCallOneVsOneModel*>*)list;

 +(ApiCfgPayCallOneVsOneModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiCfgPayCallOneVsOneModel*) source target:(ApiCfgPayCallOneVsOneModel*)target;

@end

NS_ASSUME_NONNULL_END
