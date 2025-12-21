//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppSeekUserVOModel.h"

#import "HttpNoneModel.h"

#import "AppScheduleVOModel.h"

#import "AppSkillTagVOModel.h"

#import "AppUserSkillVOModel.h"

#import "AppSkillTypeVOModel.h"

#import "AppSeekConsultantVOModel.h"

typedef void (^CallBackSeekController_AppSeekUserVOArr)(int code,NSString *strMsg,NSArray<AppSeekUserVOModel*>* arr);
typedef void (^CallBackSeekController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackSeekController_AppScheduleVOArr)(int code,NSString *strMsg,NSArray<AppScheduleVOModel*>* arr);
typedef void (^CallBackSeekController_AppSkillTagVOArr)(int code,NSString *strMsg,NSArray<AppSkillTagVOModel*>* arr);
typedef void (^CallBackSeekController_AppUserSkillVOArr)(int code,NSString *strMsg,NSArray<AppUserSkillVOModel*>* arr);
typedef void (^CallBackSeekController_AppSkillTypeVOArr)(int code,NSString *strMsg,NSArray<AppSkillTypeVOModel*>* arr);
typedef void (^CallBackSeekController_AppUserSkillVO)(int code,NSString *strMsg,AppUserSkillVOModel* model);
typedef void (^CallBackSeekController_AppSeekConsultantVO)(int code,NSString *strMsg,AppSeekConsultantVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
寻觅技能相关控制层
 */
@interface HttpApiSeekController: NSObject



/**
 获取寻觅首页用户数据
 @param isAround 查询附近 0：不是 1：是
 @param isNew 查询新人 0：不是 1：是
 @param isRecommend 查询推荐 0.不是，1.是
 @param latitude 纬度，未获取到传0
 @param longitude 经度，未获取到传0
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param skillTypeId 技能类型id
 */
+(void) getSeekHomeUserList:(int)isAround isNew:(int)isNew isRecommend:(int)isRecommend latitude:(double)latitude longitude:(double)longitude pageIndex:(int)pageIndex pageSize:(int)pageSize skillTypeId:(int64_t)skillTypeId  callback:(CallBackSeekController_AppSeekUserVOArr)callback;


/**
 申请成为顾问
 @param backView 身份证反面
 @param frontView 身份证正面
 @param handsetView 手持身份证
 */
+(void) addSeekConsultant:(NSString *)backView frontView:(NSString *)frontView handsetView:(NSString *)handsetView  callback:(CallBackSeekController_HttpNone)callback;


/**
 用户添加技能
 @param featuredPicture 技能展示图片多张，用逗号衔接
 @param schedule 档期 1：早上 2：中午 3：晚上,(多个用逗号隔开)
 @param skillTextDescription 技能文字描述
 @param skillTypeId 技能类型id
 @param skillTypeIdOld 旧技能id（没有传0）
 @param skillTypeTagIds 技能标签id集，中间逗号隔开
 @param unitPrice 每小时单价
 */
+(void) setAppUserSkill:(NSString *)featuredPicture schedule:(NSString *)schedule skillTextDescription:(NSString *)skillTextDescription skillTypeId:(int64_t)skillTypeId skillTypeIdOld:(int64_t)skillTypeIdOld skillTypeTagIds:(NSString *)skillTypeTagIds unitPrice:(double)unitPrice  callback:(CallBackSeekController_HttpNone)callback;


/**
 获取档期列表
 */
+(void) getAppScheduleList:(CallBackSeekController_AppScheduleVOArr)callback;


/**
 获取技能标签列表
 @param skillTypeId 技能类型id
 */
+(void) getSkillTagList:(int64_t)skillTypeId  callback:(CallBackSeekController_AppSkillTagVOArr)callback;


/**
 获取用户的技能列表
 @param toUserId 被查看人的用户id
 */
+(void) getAppUserSkillList:(int64_t)toUserId  callback:(CallBackSeekController_AppUserSkillVOArr)callback;


/**
 获取技能类型列表
 @param userId 用户id（查全部时，传0）
 */
+(void) getSkillTypeList:(int64_t)userId  callback:(CallBackSeekController_AppSkillTypeVOArr)callback;


/**
 删除用户的一个技能
 @param skillTypeId 技能类型id
 */
+(void) delAppUserSkill:(int64_t)skillTypeId  callback:(CallBackSeekController_HttpNone)callback;


/**
 获取用户一个技能的信息
 @param skillTypeId 技能类型id
 @param toUserId 被查看人的用户id
 */
+(void) getAppUserSkill:(int64_t)skillTypeId toUserId:(int64_t)toUserId  callback:(CallBackSeekController_AppUserSkillVO)callback;


/**
 获取寻觅顾问认证信息
 */
+(void) getSeekConsultant:(CallBackSeekController_AppSeekConsultantVO)callback;

@end

NS_ASSUME_NONNULL_END
