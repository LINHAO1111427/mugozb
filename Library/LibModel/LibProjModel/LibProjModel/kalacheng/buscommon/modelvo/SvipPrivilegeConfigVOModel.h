//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
SVIP特权说明
 */
@interface SvipPrivilegeConfigVOModel : NSObject 


	/**
svip每日赠送分钟数
 */
@property (nonatomic, assign) int svipCallTime;

	/**
排序
 */
@property (nonatomic, assign) int orderNo;

	/**
svip每日赠送次数
 */
@property (nonatomic, assign) int svipCallSecond;

	/**
特权描述
 */
@property (nonatomic, copy) NSString * privilegeDescription;

	/**
特权图片
 */
@property (nonatomic, copy) NSString * privilegeImage;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
特权标识
 */
@property (nonatomic, copy) NSString * privilegeMark;

	/**
特权标题
 */
@property (nonatomic, copy) NSString * privilegeTitle;

	/**
是否启用 1:启用 0：禁止
 */
@property (nonatomic, assign) int isEnable;

	/**
特权名称
 */
@property (nonatomic, copy) NSString * privilegeName;

 +(NSMutableArray<SvipPrivilegeConfigVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SvipPrivilegeConfigVOModel*>*)list;

 +(SvipPrivilegeConfigVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SvipPrivilegeConfigVOModel*) source target:(SvipPrivilegeConfigVOModel*)target;

@end

NS_ASSUME_NONNULL_END
