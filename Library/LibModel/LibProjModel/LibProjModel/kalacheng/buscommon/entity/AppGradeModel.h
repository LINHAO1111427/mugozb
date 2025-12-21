//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
等级
 */
@interface AppGradeModel : NSObject 


	/**
贵族坐骑名称
 */
@property (nonatomic, copy) NSString * vipCarName;

	/**
标准值范围_头
 */
@property (nonatomic, assign) int startVal;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
对应坐骑的ID =
 */
@property (nonatomic, assign) int appCarId;

	/**
通话折扣
 */
@property (nonatomic, assign) double callDiscount;

	/**
类型 1:用户等级 2：财富等级 3：主播等级 4：贵族等级
 */
@property (nonatomic, assign) int type;

	/**
勋章级别， 唯一， 不变
 */
@property (nonatomic, assign) int medalLv;

	/**
是否启用 1:启用 0：关闭
 */
@property (nonatomic, assign) int isEnable;

	/**
等级icon
 */
@property (nonatomic, copy) NSString * gradeIcon;

	/**
是否有奖励活动参与资格， 0:没有， 1：有
 */
@property (nonatomic, assign) int isJoinActiveAuth;

	/**
标准值单位
 */
@property (nonatomic, copy) NSString * unit;

	/**
是否有系统推荐位， 0:没有， 1：有
 */
@property (nonatomic, assign) int isSysRecommend;

	/**
充值折扣
 */
@property (nonatomic, assign) double rechargeDiscount;

	/**
等级
 */
@property (nonatomic, assign) int grade;

	/**
等级头像框
 */
@property (nonatomic, copy) NSString * avatarFrame;

	/**
等级名称
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
勋章ID
 */
@property (nonatomic, assign) int64_t medalId;

	/**
麦位框ID
 */
@property (nonatomic, assign) int64_t micBorderId;

 +(NSMutableArray<AppGradeModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradeModel*>*)list;

 +(AppGradeModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppGradeModel*) source target:(AppGradeModel*)target;

@end

NS_ASSUME_NONNULL_END
