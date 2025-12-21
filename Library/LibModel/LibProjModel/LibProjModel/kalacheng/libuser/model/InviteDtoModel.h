//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppInviteImgModel;
 @class KeyValueDtoModel;
NS_ASSUME_NONNULL_BEGIN




/**
邀请码
 */
@interface InviteDtoModel : NSObject 


	/**
分享图片背景图集合
 */
@property (nonatomic, strong) NSMutableArray<AppInviteImgModel*>* shareBackgroundImgList;

	/**
剩余佣金
 */
@property (nonatomic, assign) double amount;

	/**
标题图片
 */
@property (nonatomic, copy) NSString * titleImg;

	/**
邀请码
 */
@property (nonatomic, copy) NSString * code;

	/**
提示信息1
 */
@property (nonatomic, copy) NSString * msg1;

	/**
微信邀请
 */
@property (strong, nonatomic) KeyValueDtoModel* wxInvite;

	/**
邀请规则
 */
@property (nonatomic, copy) NSString * inviteRule;

	/**
图片分享
 */
@property (strong, nonatomic) KeyValueDtoModel* shareImg;

	/**
总收益佣金
 */
@property (nonatomic, assign) double totalAmount;

	/**
背景图
 */
@property (nonatomic, copy) NSString * backgroundImg;

	/**
QQ邀请
 */
@property (strong, nonatomic) KeyValueDtoModel* qqInvite;

	/**
邀请地址
 */
@property (nonatomic, copy) NSString * inviteUrl;

	/**
累计提现佣金
 */
@property (nonatomic, assign) double totalCash;

	/**
已邀请人数
 */
@property (nonatomic, assign) int inviteUserNum;

 +(NSMutableArray<InviteDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<InviteDtoModel*>*)list;

 +(InviteDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(InviteDtoModel*) source target:(InviteDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
