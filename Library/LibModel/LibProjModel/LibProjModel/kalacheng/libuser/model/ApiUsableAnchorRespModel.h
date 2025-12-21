//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP获取可互动主播响应
 */
@interface ApiUsableAnchorRespModel : NSObject 


	/**
是否可互动 1:可互动 0:不可互动
 */
@property (nonatomic, assign) int ismic;

	/**
当前用户财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
当前用户贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
用户性别 0:保密 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
当前用户贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
直播id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户昵称
 */
@property (nonatomic, copy) NSString * userName;

	/**
当前用户贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户年龄
 */
@property (nonatomic, assign) int age;

 +(NSMutableArray<ApiUsableAnchorRespModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsableAnchorRespModel*>*)list;

 +(ApiUsableAnchorRespModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsableAnchorRespModel*) source target:(ApiUsableAnchorRespModel*)target;

@end

NS_ASSUME_NONNULL_END
