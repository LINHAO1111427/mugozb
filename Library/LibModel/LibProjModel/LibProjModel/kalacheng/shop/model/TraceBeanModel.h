//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
物流轨迹
 */
@interface TraceBeanModel : NSObject 


	/**
时间
 */
@property (nonatomic, copy) NSString * time;

	/**
状态
 */
@property (nonatomic, copy) NSString * status;

 +(NSMutableArray<TraceBeanModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TraceBeanModel*>*)list;

 +(TraceBeanModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TraceBeanModel*) source target:(TraceBeanModel*)target;

@end

NS_ASSUME_NONNULL_END
