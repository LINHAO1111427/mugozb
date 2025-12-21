//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP签到管理
 */
@interface ApiSignInModel : NSObject 


	/**
礼物id
 */
@property (nonatomic, assign) int64_t giftId;

	/**
图片
 */
@property (nonatomic, copy) NSString * image;

	/**
领取状态0可领取1已领取2不可领取
 */
@property (nonatomic, assign) int isGet;

	/**
类型值:金币 /个数
 */
@property (nonatomic, assign) int typeVal;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
签到天数
 */
@property (nonatomic, assign) int dayNumber;

	/**
礼物名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int id_field;

	/**
类型 1:金币 2:礼物
 */
@property (nonatomic, assign) int type;

 +(NSMutableArray<ApiSignInModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSignInModel*>*)list;

 +(ApiSignInModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSignInModel*) source target:(ApiSignInModel*)target;

@end

NS_ASSUME_NONNULL_END
