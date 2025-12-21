//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class FixedWithdrawRuleVOModel;
 @class TicketExchangeRuleModel;
 @class CfgCurrencySettingModel;
 @class AppUsersCashAccountModel;
NS_ASSUME_NONNULL_BEGIN




/**
收益中心
 */
@interface ProfitCenterDTOModel : NSObject 


	/**
兑换金币 0:关闭 1:开启
 */
@property (nonatomic, assign) int coinExchange;

	/**
公会收益
 */
@property (nonatomic, assign) double guildAccount;

	/**
公会图像
 */
@property (nonatomic, copy) NSString * guildAvatar;

	/**
是否有寻觅
 */
@property (nonatomic, assign) int haveSeek;

	/**
映票提现最低额度
 */
@property (nonatomic, assign) double cashMin;

	/**
提现金额方式 0:灵活输入 1:固定数值
 */
@property (nonatomic, assign) int withdrawalAmountManner;

	/**
跳转积分系统IOS字符串
 */
@property (nonatomic, copy) NSString * goToScoreSystemIOS;

	/**
佣金使用映票结算 0：不开启 1：开启
 */
@property (nonatomic, assign) int recommendCommissionTicket;

	/**
佣金手续费 小数
 */
@property (nonatomic, assign) double amountService;

	/**
主播与公会的分成比例
 */
@property (nonatomic, assign) double perc;

	/**
主播公会的累计收益
 */
@property (nonatomic, assign) double anchorGuildCumulativeIncome;

	/**
佣金提现最低额度
 */
@property (nonatomic, assign) double amountMin;

	/**
跳转积分系统说明文本
 */
@property (nonatomic, copy) NSString * goToScoreSystemText;

	/**
主播等级图标
 */
@property (nonatomic, copy) NSString * gradeAvatar;

	/**
单日最大提现次数
 */
@property (nonatomic, assign) int cashMaxDay;

	/**
单月最大提现次数
 */
@property (nonatomic, assign) int cashMaxMonth;

	/**
提现比例
 */
@property (nonatomic, assign) double cashRate;

	/**
提现金额数组
 */
@property (nonatomic, strong) NSMutableArray<FixedWithdrawRuleVOModel*>* fixedWithdrawRuleVOList;

	/**
如果不为空，则APP端无提醒相关按钮，而是显示这段文字
 */
@property (nonatomic, copy) NSString * noAppCashDesc;

	/**
是否跳转积分系统
 */
@property (nonatomic, assign) int haveGoToScoreSystem;

	/**
兑换规则列表
 */
@property (nonatomic, strong) NSMutableArray<TicketExchangeRuleModel*>* exchangeRuleList;

	/**
平台总收益
 */
@property (nonatomic, assign) double votestotal;

	/**
ios功能开启 0：不开启 1：开启
 */
@property (nonatomic, assign) int isFunctionTurnOn;

	/**
用户图像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
公会的分成比例
 */
@property (nonatomic, assign) double guildPerc;

	/**
公会id
 */
@property (nonatomic, assign) int64_t guildId;

	/**
只有主播才能提现 0：不启用 1：启用
 */
@property (nonatomic, assign) int onlyAnchorCash;

	/**
累计获得的分成映票
 */
@property (nonatomic, assign) double totalvotes;

	/**
跳转积分系统安卓字符串
 */
@property (nonatomic, copy) NSString * goToScoreSystemAndroid;

	/**
货币名称，图片
 */
@property (strong, nonatomic) CfgCurrencySettingModel* cfgCurrency;

	/**
金币手续费 小数
 */
@property (nonatomic, assign) double service;

	/**
主播等级
 */
@property (nonatomic, assign) int grade;

	/**
平台可提收益
 */
@property (nonatomic, assign) double votes;

	/**
规则描述
 */
@property (nonatomic, copy) NSString * describe;

	/**
用户积分系统
 */
@property (nonatomic, assign) int haveUserScoreSystem;

	/**
提现用户的角色 0：用户 1：主播
 */
@property (nonatomic, assign) int userRole;

	/**
默认账号
 */
@property (strong, nonatomic) AppUsersCashAccountModel* account;

	/**
公会的累计收益
 */
@property (nonatomic, assign) double guildCumulativeIncome;

 +(NSMutableArray<ProfitCenterDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ProfitCenterDTOModel*>*)list;

 +(ProfitCenterDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ProfitCenterDTOModel*) source target:(ProfitCenterDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
