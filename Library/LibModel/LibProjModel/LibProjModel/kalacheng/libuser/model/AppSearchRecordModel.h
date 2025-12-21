//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
搜索记录
 */
@interface AppSearchRecordModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
累计搜索次数
 */
@property (nonatomic, assign) int num;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
搜索内容
 */
@property (nonatomic, copy) NSString * content;

 +(NSMutableArray<AppSearchRecordModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSearchRecordModel*>*)list;

 +(AppSearchRecordModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSearchRecordModel*) source target:(AppSearchRecordModel*)target;

@end

NS_ASSUME_NONNULL_END
