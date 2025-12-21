//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀请码背景图设置
 */
@interface AppInviteImgModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
是否启用 0：不使用 1：使用
 */
@property (nonatomic, assign) int isTip;

	/**
图片地址
 */
@property (nonatomic, copy) NSString * url;

 +(NSMutableArray<AppInviteImgModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppInviteImgModel*>*)list;

 +(AppInviteImgModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppInviteImgModel*) source target:(AppInviteImgModel*)target;

@end

NS_ASSUME_NONNULL_END
