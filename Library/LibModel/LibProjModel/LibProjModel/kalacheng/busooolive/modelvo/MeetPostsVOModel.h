//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
遇见(速配)页面数据
 */
@interface MeetPostsVOModel : NSObject 


	/**
速配说明
 */
@property (nonatomic, copy) NSString * multiplayerRule;

	/**
一对一速配背景图
 */
@property (nonatomic, copy) NSString * oooSpeedDating;

 +(NSMutableArray<MeetPostsVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MeetPostsVOModel*>*)list;

 +(MeetPostsVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MeetPostsVOModel*) source target:(MeetPostsVOModel*)target;

@end

NS_ASSUME_NONNULL_END
