//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
主播认证
 */
@interface AppUsersAuthModel : NSObject 


	/**
qq账号
 */
@property (nonatomic, copy) NSString * qq;

	/**
主播星级id（该字段没有实际意义仅审核时用，请勿依赖）
 */
@property (nonatomic, assign) int64_t starId;

	/**
其他资料图3
 */
@property (nonatomic, copy) NSString * other3View;

	/**
审核说明
 */
@property (nonatomic, copy) NSString * reason;

	/**
提交时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
反面
 */
@property (nonatomic, copy) NSString * backView;

	/**
电话
 */
@property (nonatomic, copy) NSString * mobile;

	/**
所属区域家族id
 */
@property (nonatomic, assign) int pidLevel2;

	/**
微信账号
 */
@property (nonatomic, copy) NSString * wechat;

	/**
所属总家族ID
 */
@property (nonatomic, assign) int pidLevel1;

	/**
所属经纪人id
 */
@property (nonatomic, assign) int pidLevel4;

	/**
其他资料图1
 */
@property (nonatomic, copy) NSString * other1View;

	/**
所属家族id
 */
@property (nonatomic, assign) int pidLevel3;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * uptime;

	/**
正面
 */
@property (nonatomic, copy) NSString * frontView;

	/**
姓名
 */
@property (nonatomic, copy) NSString * realName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
身份证号
 */
@property (nonatomic, copy) NSString * cerNo;

	/**
手持
 */
@property (nonatomic, copy) NSString * handsetView;

	/**
短视频地址
 */
@property (nonatomic, copy) NSString * videoUrl;

	/**
步骤
 */
@property (nonatomic, assign) int step;

	/**
其他资料图2
 */
@property (nonatomic, copy) NSString * other2View;

	/**
附加信息，用于确认分销商
 */
@property (nonatomic, copy) NSString * extraInfo;

	/**
审核状态 1:待审核 2:审核拒绝 0:审核通过  -1：资料提交中
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppUsersAuthModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersAuthModel*>*)list;

 +(AppUsersAuthModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUsersAuthModel*) source target:(AppUsersAuthModel*)target;

@end

NS_ASSUME_NONNULL_END
