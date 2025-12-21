//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
直播间靓号表
 */
@interface AppLiangModel : NSObject 


	/**
序号
 */
@property (nonatomic, assign) int orderno;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
靓号长度
 */
@property (nonatomic, assign) int length;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
购买时间
 */
@property (nonatomic,copy) NSDate * buytime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
启用状态  0:未启用  1：正在启用
 */
@property (nonatomic, assign) int state;

	/**
购买用户ID
 */
@property (nonatomic, assign) int64_t userid;

	/**
价格
 */
@property (nonatomic, assign) double coin;

	/**
靓号销售状态0为销售；1已销售
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppLiangModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiangModel*>*)list;

 +(AppLiangModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppLiangModel*) source target:(AppLiangModel*)target;

@end

NS_ASSUME_NONNULL_END
