//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
提现记录
 */
@interface CashRecordDTOModel : NSObject 


	/**
实际到账金额
 */
@property (nonatomic, assign) double actualMoney;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t uid;

	/**
提现类型(公会为0)：1:主播向平台 2:佣金 3:主播向公会 4:商家提现 5：映票兑换金币
 */
@property (nonatomic, assign) int cashType;

	/**
剩余映票数
 */
@property (nonatomic, assign) double surplusVotes;

	/**
申请时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
提现数量
 */
@property (nonatomic, assign) double votes;

	/**
账号类型：1。支付宝 2。微信 3。银行卡
 */
@property (nonatomic, assign) int type;

	/**
公会ID
 */
@property (nonatomic, assign) int64_t guildId;

	/**
备注
 */
@property (nonatomic, copy) NSString * remarks;

	/**
状态，0审核中，1审核通过，2审核拒绝
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<CashRecordDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CashRecordDTOModel*>*)list;

 +(CashRecordDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CashRecordDTOModel*) source target:(CashRecordDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
