//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
等级特权
 */
@interface AppGradePrivilegeModel : NSObject 


	/**
在线logo
 */
@property (nonatomic, copy) NSString * lineLogo;

	/**
是否启用 0：未启用， 1：启用
 */
@property (nonatomic, assign) int isStart;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
特权类型 1:用户特权 2:财富特权 3:主播特权 4:贵族特权 5:魅力特权
 */
@property (nonatomic, assign) int type;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
特权描述
 */
@property (nonatomic, copy) NSString * desr;

	/**
是否显示在后台(管理员使用字段)
 */
@property (nonatomic, assign) int isShow;

	/**
不在线logo
 */
@property (nonatomic, copy) NSString * offLineLogo;

	/**
标识
 */
@property (nonatomic, copy) NSString * identification;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
等级
 */
@property (nonatomic, assign) int grade;

	/**
特权名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
0：未拥有 1：已拥有
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppGradePrivilegeModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradePrivilegeModel*>*)list;

 +(AppGradePrivilegeModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppGradePrivilegeModel*) source target:(AppGradePrivilegeModel*)target;

@end

NS_ASSUME_NONNULL_END
