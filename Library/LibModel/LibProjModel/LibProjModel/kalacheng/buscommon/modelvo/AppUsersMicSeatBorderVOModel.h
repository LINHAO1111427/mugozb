//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户麦位饰品
 */
@interface AppUsersMicSeatBorderVOModel : NSObject 


	/**
麦位饰品头像
 */
@property (nonatomic, copy) NSString * thumb;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
麦位饰品名称
 */
@property (nonatomic, copy) NSString * name;

	/**
到期时间
 */
@property (nonatomic,copy) NSDate * endtime;

	/**
麦位饰品ID
 */
@property (nonatomic, assign) int64_t seatid;

	/**
id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userid;

	/**
是否启用
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppUsersMicSeatBorderVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersMicSeatBorderVOModel*>*)list;

 +(AppUsersMicSeatBorderVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUsersMicSeatBorderVOModel*) source target:(AppUsersMicSeatBorderVOModel*)target;

@end

NS_ASSUME_NONNULL_END
