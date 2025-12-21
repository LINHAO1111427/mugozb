//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppUserTaskRecordModel;
NS_ASSUME_NONNULL_BEGIN




/**
任务查询结果
 */
@interface TaskDtoModel : NSObject 


	/**
任务值
 */
@property (nonatomic, assign) double val;

	/**
任务图片
 */
@property (nonatomic, copy) NSString * image;

	/**
任务图片
 */
@property (nonatomic, copy) NSString * taskImg;

	/**
任务角色 0:用户任务  1：主播任务
 */
@property (nonatomic, assign) int role;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
任务每日完成类型 1：每日任务 2：累计任务
 */
@property (nonatomic, assign) int taskCompletionType;

	/**
是否开启任务  0：关闭  1：开启
 */
@property (nonatomic, assign) int isStart;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
获得勋章的任务记录
 */
@property (strong, nonatomic) AppUserTaskRecordModel* appUserTaskRecord;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
简介描述
 */
@property (nonatomic, copy) NSString * desr;

	/**
经验积分
 */
@property (nonatomic, assign) int point;

	/**
任务类型编码
 */
@property (nonatomic, copy) NSString * typeCode;

	/**
任务分类 0：普通任务 1：直播任务 2:交友任务 3:短视频任务
 */
@property (nonatomic, assign) int taskType;

	/**
任务值单位
 */
@property (nonatomic, copy) NSString * unit;

	/**
任务名称
 */
@property (nonatomic, copy) NSString * name;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * startTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否完成任务 ， 是否获得0：未完成(默认) 1：已完成
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<TaskDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TaskDtoModel*>*)list;

 +(TaskDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TaskDtoModel*) source target:(TaskDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
