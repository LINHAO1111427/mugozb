//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
弹框socket数据
 */
@interface ApiElasticFrameModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomid;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
消息内容
 */
@property (nonatomic, copy) NSString * content;

	/**
消息类型 1:用戶升级 2:完成任务 3:获得勋章 4:开通贵族
 */
@property (nonatomic, assign) int type;

	/**
type = 1时 childType: 1:用户等级升级  2：主播等级升级  3：财富等级升级   5：魅力等级升级（贵族无等级通知，仅勋章通知即可）;type = 2时 childType: 1:用户任务（限时任务）  2：主播任务（累计任务）;type = 3时 childType: 1:普通勋章  2：财富勋章  3：贵族勋章
 */
@property (nonatomic, assign) int childType;

	/**
对应childType名称
 */
@property (nonatomic, copy) NSString * childTypeName;

	/**
贵族名称(会员)
 */
@property (nonatomic, copy) NSString * vipName;

	/**
等级
 */
@property (nonatomic, copy) NSString * grade;

	/**
任务标题
 */
@property (nonatomic, copy) NSString * taskName;

	/**
经验值
 */
@property (nonatomic, assign) int taskPoint;

	/**
勋章名称
 */
@property (nonatomic, copy) NSString * medalName;

	/**
勋章LOGO
 */
@property (nonatomic, copy) NSString * medalLogo;

 +(NSMutableArray<ApiElasticFrameModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiElasticFrameModel*>*)list;

 +(ApiElasticFrameModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiElasticFrameModel*) source target:(ApiElasticFrameModel*)target;

@end

NS_ASSUME_NONNULL_END
