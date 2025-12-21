//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP用户任务
 */
@interface AppUserTaskRecordModel : NSObject 


	/**
最后一次完成任务时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
任务角色 0:用户任务  1：主播任务
 */
@property (nonatomic, assign) int role;

	/**
任务完成时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
任务每日完成类型 1：每日任务 2：累计任务
 */
@property (nonatomic, assign) int taskCompletionType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
任务是否已完成 0:未完成 1：已完成
 */
@property (nonatomic, assign) int isFinish;

	/**
完成任务值
 */
@property (nonatomic, assign) double totalTaskVal;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
任务完成后获取的积分
 */
@property (nonatomic, assign) int point;

	/**
任务ID
 */
@property (nonatomic, assign) int64_t taskId;

	/**
任务类型编码
 */
@property (nonatomic, copy) NSString * typeCode;

 +(NSMutableArray<AppUserTaskRecordModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserTaskRecordModel*>*)list;

 +(AppUserTaskRecordModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserTaskRecordModel*) source target:(AppUserTaskRecordModel*)target;

@end

NS_ASSUME_NONNULL_END
