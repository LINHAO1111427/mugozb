//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "RanksDtoModel.h"

#import "HttpNoneModel.h"

#import "AppUserIncomeRankingDtoModel.h"

#import "ProfitCenterDTOModel.h"

#import "AnchorVotesDTOModel.h"

#import "WithdrawalMethodModel.h"

#import "AppUsersCashAccountModel.h"

#import "CashRecordDTOModel.h"

#import "GuildListVOModel.h"

typedef void (^CallBackAPPFinance_RanksDtoPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<RanksDtoModel*>* arr);
typedef void (^CallBackAPPFinance_RanksDtoArr)(int code,NSString *strMsg,NSArray<RanksDtoModel*>* arr);
typedef void (^CallBackAPPFinance_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAPPFinance_AppUserIncomeRankingDtoPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<AppUserIncomeRankingDtoModel*>* arr);
typedef void (^CallBackAPPFinance_ProfitCenterDTO)(int code,NSString *strMsg,ProfitCenterDTOModel* model);
typedef void (^CallBackAPPFinance_AnchorVotesDTO)(int code,NSString *strMsg,AnchorVotesDTOModel* model);
typedef void (^CallBackAPPFinance_WithdrawalMethod)(int code,NSString *strMsg,WithdrawalMethodModel* model);
typedef void (^CallBackAPPFinance_AppUsersCashAccountArr)(int code,NSString *strMsg,NSArray<AppUsersCashAccountModel*>* arr);
typedef void (^CallBackAPPFinance_CashRecordDTOArr)(int code,NSString *strMsg,NSArray<CashRecordDTOModel*>* arr);
typedef void (^CallBackAPPFinance_GuildListVOPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<GuildListVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
资金相关接口
 */
@interface HttpApiAPPFinance: NSObject



/**
 收益榜
 @param findType 查询类型 1: 平台排行榜 2: 主播排行榜
 @param sex 性别 -1：表示全部 1：男 2：女
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 @param uid 用户id(查看礼物榜时必传,默认传0)
 */
+(void) votesList:(int)findType sex:(int)sex type:(int)type uid:(int64_t)uid  callback:(CallBackAPPFinance_RanksDtoPageArr)callback;


/**
 粉丝团排行
 @param anchorId 主播ID
 @param pageIndex 当前页
 @param pageSize 每页大小
 */
+(void) getFansTeamRank:(int64_t)anchorId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackAPPFinance_RanksDtoArr)callback;


/**
 我的收益里添加提现账号
 @param account 账号
 @param accountBank 银行名称(type为3时传入)
 @param branch 支行
 @param name 姓名
 @param recordId 相关记录ID
 @param type 类型 1：支付宝 2：微信 3：银行卡
 */
+(void) withdrawAccountAdd:(NSString *)account accountBank:(NSString *)accountBank branch:(NSString *)branch name:(NSString *)name recordId:(int64_t)recordId type:(int)type  callback:(CallBackAPPFinance_HttpNone)callback;


/**
 我的收益里删除提现账号
 @param id 提现账号id
 */
+(void) withdrawAccountDel:(int64_t)id_field  callback:(CallBackAPPFinance_HttpNone)callback;


/**
 收入排行
 @param findType 查询类型 1: 平台排行榜
 @param toUserId 用户id(查询自身排行时传,其他传0)
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 */
+(void) incomeRanking:(int)findType toUserId:(int64_t)toUserId type:(int)type  callback:(CallBackAPPFinance_AppUserIncomeRankingDtoPageArr)callback;


/**
 用户收益接口/用户公会收益 （新接口）
 @param type 1.平台收益，2.公会收益
 */
+(void) userProfit:(int)type  callback:(CallBackAPPFinance_ProfitCenterDTO)callback;


/**
 获取主播可提现账户余额(优先显示公会)
 */
+(void) anchorVotes:(CallBackAPPFinance_AnchorVotesDTO)callback;


/**
 获取提现方式
 */
+(void) getWithdrawalMethod:(CallBackAPPFinance_WithdrawalMethod)callback;


/**
 我的收益里提现账号列表
 */
+(void) withdrawAccount:(CallBackAPPFinance_AppUsersCashAccountArr)callback;


/**
 提现记录(平台/公会)
 @param date 日期
 @param pageIndex 每页的条数
 @param pageSize 每页的条数
 @param status 状态，0审核中，1审核通过，2审核拒绝，-1全部
 @param type 0.平台，1.公会
 */
+(void) userCashRecordList:(NSString *)date pageIndex:(int)pageIndex pageSize:(int)pageSize status:(int)status type:(int)type  callback:(CallBackAPPFinance_CashRecordDTOArr)callback;


/**
 用户收益映票兑换金币
 @param ruleId 兑换规则
 @param type 1.平台收益，2.公会收益
 */
+(void) ticketExchangeCoin:(int64_t)ruleId type:(int)type  callback:(CallBackAPPFinance_HttpNone)callback;


/**
 贡献榜
 @param anchorId 主播ID(findType = 2，4，查询自己排名的时候必传 )
 @param findType 查询类型 1: 平台排行榜 2: 主播排行榜 3:粉丝(关注)排行榜 4：每次直播贡献排行榜
 @param sex 性别 -1：表示全部 1：男 2：女
 @param showId 直播标识（findType = 4 时传，其他时间传 ''）
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 */
+(void) contributionList:(int64_t)anchorId findType:(int)findType sex:(int)sex showId:(NSString *)showId type:(int)type  callback:(CallBackAPPFinance_RanksDtoArr)callback;


/**
 我的收益提现申请
 @param accountId 提现账号id
 @param accountName accountName
 @param accountType 账号类型 1：支付宝  2：微信，3：银行卡
 @param delta 映票/佣金 数量 
 @param type 提现类型 1：映票  2：佣金提现 3：公会账户提现， 4：商家提现
 */
+(void) withdrawAccountApply:(int64_t)accountId accountName:(NSString *)accountName accountType:(int)accountType delta:(double)delta type:(int)type  callback:(CallBackAPPFinance_HttpNone)callback;


/**
 佣金兑换金币
 @param payTerminal 支付终端android/iOS
 @param ruleId 充值规则ID
 */
+(void) moneyExchangeCoin:(NSString *)payTerminal ruleId:(int64_t)ruleId  callback:(CallBackAPPFinance_HttpNone)callback;


/**
 公会榜
 @param type 类型 0:总榜 1:日榜 2:周榜 3:月榜
 */
+(void) guildList:(int)type  callback:(CallBackAPPFinance_GuildListVOPageArr)callback;

@end

NS_ASSUME_NONNULL_END
