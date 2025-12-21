//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class OTMAssisRetModel;
NS_ASSUME_NONNULL_BEGIN




/**
音量信息
 */
@interface OOOVolumeRetModel : NSObject 


	/**
操作人id,音量状态修改人的id
 */
@property (nonatomic, assign) int64_t operateUid;

	/**
音量状态修改人的音量状态 1:开启 0:关播
 */
@property (nonatomic, assign) int operateStatus;

	/**
主持人id
 */
@property (nonatomic, assign) int64_t hostUid;

	/**
当前房间中已接通的用户集合
 */
@property (nonatomic, strong) NSMutableArray<OTMAssisRetModel*>* otmAssisRetList;

	/**
消费人id
 */
@property (nonatomic, assign) int64_t feeUid;

 +(NSMutableArray<OOOVolumeRetModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOVolumeRetModel*>*)list;

 +(OOOVolumeRetModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOVolumeRetModel*) source target:(OOOVolumeRetModel*)target;

@end

NS_ASSUME_NONNULL_END
