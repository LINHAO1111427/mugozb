//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
麦位头像框
 */
@interface AppMicSeatBorderVOModel : NSObject 


	/**
序号
 */
@property (nonatomic, assign) int orderno;

	/**
动画链接
 */
@property (nonatomic, copy) NSString * swf;

	/**
图片链接
 */
@property (nonatomic, copy) NSString * thumb;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
价格
 */
@property (nonatomic, assign) double needcoin;

	/**
id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
状态（0显示1不显示）
 */
@property (nonatomic, assign) int status;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * uptime;

 +(NSMutableArray<AppMicSeatBorderVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMicSeatBorderVOModel*>*)list;

 +(AppMicSeatBorderVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppMicSeatBorderVOModel*) source target:(AppMicSeatBorderVOModel*)target;

@end

NS_ASSUME_NONNULL_END
