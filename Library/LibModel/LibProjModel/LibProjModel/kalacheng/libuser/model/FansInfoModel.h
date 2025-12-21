//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
粉丝信息
 */
@interface FansInfoModel : NSObject 


	/**
财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
用户等级
 */
@property (nonatomic, assign) int userGrade;

	/**
用户性别
 */
@property (nonatomic, assign) int sex;

	/**
用户等级图标
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
粉丝ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
主播等级图标
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
财富等级
 */
@property (nonatomic, assign) int wealthGrade;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<FansInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<FansInfoModel*>*)list;

 +(FansInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(FansInfoModel*) source target:(FansInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
