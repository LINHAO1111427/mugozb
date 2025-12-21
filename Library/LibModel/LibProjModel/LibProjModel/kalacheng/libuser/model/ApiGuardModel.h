//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GuardEffectModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP守护表
 */
@interface ApiGuardModel : NSObject 


	/**
提示消息
 */
@property (nonatomic, copy) NSString * msg;

	/**
时长
 */
@property (nonatomic, assign) int lengthTime;

	/**
时长类型，0天，1月，2年
 */
@property (nonatomic, assign) int lengthType;

	/**
序号
 */
@property (nonatomic, assign) int orderno;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
时长
 */
@property (nonatomic, assign) int length;

	/**
守护名称
 */
@property (nonatomic, copy) NSString * name;

	/**
守护功能
 */
@property (nonatomic, strong) NSMutableArray<GuardEffectModel*>* guardEffectList;

	/**
守护类型，1普通2尊贵
 */
@property (nonatomic, assign) int type;

	/**
null
 */
@property (nonatomic, assign) int64_t tid;

	/**
守护价格
 */
@property (nonatomic, assign) double coin;

	/**
结束时间
 */
@property (nonatomic,copy) NSDate * uptime;

 +(NSMutableArray<ApiGuardModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGuardModel*>*)list;

 +(ApiGuardModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiGuardModel*) source target:(ApiGuardModel*)target;

@end

NS_ASSUME_NONNULL_END
