//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
app设置页面
 */
@interface AppPostsModel : NSObject 


	/**
修改时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createtime;

	/**
post内容
 */
@property (nonatomic, copy) NSString * postExcerpt;

	/**
post类型
 */
@property (nonatomic, assign) int postType;

	/**
post标题
 */
@property (nonatomic, copy) NSString * postTitle;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否弹出平台使用许可条约 1：不弹出 0：弹出
 */
@property (nonatomic, assign) int isUseLicense;

	/**
post启用状态 1:启用 0：关闭
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppPostsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPostsModel*>*)list;

 +(AppPostsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppPostsModel*) source target:(AppPostsModel*)target;

@end

NS_ASSUME_NONNULL_END
