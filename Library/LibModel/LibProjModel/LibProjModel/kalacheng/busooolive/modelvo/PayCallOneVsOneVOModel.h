//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class StarPriceDOModel;
NS_ASSUME_NONNULL_BEGIN




/**
一对一形象设置
 */
@interface PayCallOneVsOneVOModel : NSObject 


	/**
展示声音
 */
@property (nonatomic, copy) NSString * voice;

	/**
视频费用列表
 */
@property (nonatomic, strong) NSMutableArray<StarPriceDOModel*>* videoPriceList;

	/**
视频通话时间金币/min
 */
@property (nonatomic, assign) double videoCoin;

	/**
展示视频封面
 */
@property (nonatomic, copy) NSString * videoImg;

	/**
语音通话时间金币/min
 */
@property (nonatomic, assign) double voiceCoin;

	/**
语音费用列表
 */
@property (nonatomic, strong) NSMutableArray<StarPriceDOModel*>* voicePriceList;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
展示视频
 */
@property (nonatomic, copy) NSString * video;

	/**
海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
展示声音时长
 */
@property (nonatomic, assign) int64_t voiceTime;

	/**
一对一状态 0:在线 1:忙碌 2:离开 3:通话中
 */
@property (nonatomic, assign) int liveState;

 +(NSMutableArray<PayCallOneVsOneVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PayCallOneVsOneVOModel*>*)list;

 +(PayCallOneVsOneVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(PayCallOneVsOneVOModel*) source target:(PayCallOneVsOneVOModel*)target;

@end

NS_ASSUME_NONNULL_END
