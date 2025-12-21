//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
系统公告
 */
@interface SysNoticModel : NSObject 


	/**
公告形式 1:文字 2:图片
 */
@property (nonatomic, assign) int shape;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
图片地址
 */
@property (nonatomic, copy) NSString * imageUrl;

	/**
展示方式 1:启动app时 2:每天弹一次
 */
@property (nonatomic, assign) int showType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

	/**
类型 1:首页系统公告
 */
@property (nonatomic, assign) int type;

	/**
内容
 */
@property (nonatomic, copy) NSString * content;

	/**
连接地址
 */
@property (nonatomic, copy) NSString * url;

	/**
状态 0:开启 1:关闭
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<SysNoticModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SysNoticModel*>*)list;

 +(SysNoticModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SysNoticModel*) source target:(SysNoticModel*)target;

@end

NS_ASSUME_NONNULL_END
