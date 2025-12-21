//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
一对一形象设置
 */
@interface PayCallOneVsOneDOModel : NSObject 


	/**
展示声音
 */
@property (nonatomic, copy) NSString * voice;

	/**
标签
 */
@property (nonatomic, copy) NSString * tabName;

	/**
一对一打开状态 0：默认，不打开  1：打开
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
更新时间
 */
@property (nonatomic,copy) NSDate * updateTime;

	/**
展示视频
 */
@property (nonatomic, copy) NSString * video;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
热门标签
 */
@property (nonatomic, assign) int64_t hotSortId;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
语音通话时间金币/min
 */
@property (nonatomic, assign) double voiceCoin;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
展示声音时长
 */
@property (nonatomic, assign) int64_t voiceTime;

	/**
备注
 */
@property (nonatomic, copy) NSString * remarks;

	/**
一对一状态 0:在线 1:忙碌 2:离开 3:通话中
 */
@property (nonatomic, assign) int liveState;

 +(NSMutableArray<PayCallOneVsOneDOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PayCallOneVsOneDOModel*>*)list;

 +(PayCallOneVsOneDOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(PayCallOneVsOneDOModel*) source target:(PayCallOneVsOneDOModel*)target;

@end

NS_ASSUME_NONNULL_END
