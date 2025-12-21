//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
通话记录数据
 */
@interface CallRecordDtoModel : NSObject 


	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
第n次通话
 */
@property (nonatomic, assign) int num;

	/**
是否视频直播 0：语音  1：视频
 */
@property (nonatomic, assign) int isVideo;

	/**
创建时间描述
 */
@property (nonatomic, copy) NSString * createTimeDesr;

	/**
时长描述
 */
@property (nonatomic, copy) NSString * longTimeDesr;

	/**
开始时间
 */
@property (nonatomic,copy) NSDate * startTime;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
结束时间
 */
@property (nonatomic,copy) NSDate * endTime;

	/**
主播ID
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
观众ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<CallRecordDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CallRecordDtoModel*>*)list;

 +(CallRecordDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CallRecordDtoModel*) source target:(CallRecordDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
