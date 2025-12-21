//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
等级升级大礼包列表
 */
@interface ApiGradeReListModel : NSObject 


	/**
数量
 */
@property (nonatomic, assign) int number;

	/**
图片地址
 */
@property (nonatomic, copy) NSString * img;

	/**
礼包名称
 */
@property (nonatomic, copy) NSString * title;

	/**
礼包类型 1:金币 2:坐骑 3:礼物 4:短视频
 */
@property (nonatomic, assign) int type;

 +(NSMutableArray<ApiGradeReListModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGradeReListModel*>*)list;

 +(ApiGradeReListModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiGradeReListModel*) source target:(ApiGradeReListModel*)target;

@end

NS_ASSUME_NONNULL_END
