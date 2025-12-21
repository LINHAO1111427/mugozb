//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
Im用户或群组扩展信息
 */
@interface ImExtraInfoModel : NSObject 


	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
角色，0普通用户，1主播
 */
@property (nonatomic, assign) int role;

	/**
svip图标
 */
@property (nonatomic, copy) NSString * svipIcon;

	/**
性别 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
UGID，用户群组标识
 */
@property (nonatomic, assign) int64_t UGID;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
家族等级图标
 */
@property (nonatomic, copy) NSString * gradeIcon;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
昵称
 */
@property (nonatomic, copy) NSString * name;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
昵称1(后台使用)
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ImExtraInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ImExtraInfoModel*>*)list;

 +(ImExtraInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ImExtraInfoModel*) source target:(ImExtraInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
