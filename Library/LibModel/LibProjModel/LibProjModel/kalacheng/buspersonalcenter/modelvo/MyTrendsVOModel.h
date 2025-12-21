//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppTrendsRecordModel;
NS_ASSUME_NONNULL_BEGIN




/**
我的动态
 */
@interface MyTrendsVOModel : NSObject 


	/**
时间轴
 */
@property (nonatomic, strong) NSMutableArray<AppTrendsRecordModel*>* trends;

 +(NSMutableArray<MyTrendsVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyTrendsVOModel*>*)list;

 +(MyTrendsVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MyTrendsVOModel*) source target:(MyTrendsVOModel*)target;

@end

NS_ASSUME_NONNULL_END
