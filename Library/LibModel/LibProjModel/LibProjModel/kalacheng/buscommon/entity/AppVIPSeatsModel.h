//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
贵宾席表
 */
@interface AppVIPSeatsModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
购买时间
 */
@property (nonatomic,copy) NSDate * creatTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
贵宾席类型 1:视频 2:语音
 */
@property (nonatomic, assign) int type;

	/**
购买状态 0:没有购买 1:购买
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppVIPSeatsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppVIPSeatsModel*>*)list;

 +(AppVIPSeatsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppVIPSeatsModel*) source target:(AppVIPSeatsModel*)target;

@end

NS_ASSUME_NONNULL_END
