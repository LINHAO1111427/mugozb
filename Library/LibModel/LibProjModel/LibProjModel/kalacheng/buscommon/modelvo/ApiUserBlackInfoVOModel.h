//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
被拉黑用户的基本信息
 */
@interface ApiUserBlackInfoVOModel : NSObject 


	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
用户性别
 */
@property (nonatomic, assign) int userSex;

	/**
魅力等级图片
 */
@property (nonatomic, copy) NSString * charmGradeImg;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
用户等级图片
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户年龄
 */
@property (nonatomic, assign) int userAge;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
用户角色
 */
@property (nonatomic, assign) int userRole;

 +(NSMutableArray<ApiUserBlackInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserBlackInfoVOModel*>*)list;

 +(ApiUserBlackInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserBlackInfoVOModel*) source target:(ApiUserBlackInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
