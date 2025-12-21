//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
寻觅首页用户信息vo
 */
@interface AppSeekUserVOModel : NSObject 


	/**
技能每小时单价
 */
@property (nonatomic, assign) double unitPrice;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
距离
 */
@property (nonatomic, assign) double distance;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
技能标签，取第一个技能的
 */
@property (nonatomic, copy) NSString * skillTagArr;

	/**
技能文字描述
 */
@property (nonatomic, copy) NSString * skillTextDescription;

	/**
性别 0:未设置 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
技能特权展示图片，多张，英文逗号隔开，就是下面多张图片和一个合集
 */
@property (nonatomic, copy) NSString * featuredPicture;

	/**
全部技能名称，逗号隔开
 */
@property (nonatomic, copy) NSString * skillNameArr;

	/**
技能图片
 */
@property (nonatomic, copy) NSString * skillImage;

 +(NSMutableArray<AppSeekUserVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSeekUserVOModel*>*)list;

 +(AppSeekUserVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSeekUserVOModel*) source target:(AppSeekUserVOModel*)target;

@end

NS_ASSUME_NONNULL_END
