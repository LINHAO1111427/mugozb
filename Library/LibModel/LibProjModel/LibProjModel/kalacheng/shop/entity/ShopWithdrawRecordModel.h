//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
提现记录
 */
@interface ShopWithdrawRecordModel : NSObject 


	/**
提现金额
 */
@property (nonatomic, assign) double amount;

	/**
订单号
 */
@property (nonatomic, copy) NSString * orderNo;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商家id
 */
@property (nonatomic, assign) int64_t businessId;

	/**
主播Id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
实际提现金额
 */
@property (nonatomic, assign) double realAmount;

	/**
支付账号Id
 */
@property (nonatomic, assign) int64_t accountId;

	/**
修改时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
小店余额
 */
@property (nonatomic, assign) double balance;

	/**
服务费率
 */
@property (nonatomic, assign) double servicePerc;

	/**
平台佣金比例
 */
@property (nonatomic, assign) double platformPerc;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
服务费
 */
@property (nonatomic, assign) double serviceMoney;

	/**
备注
 */
@property (nonatomic, copy) NSString * remarks;

	/**
平台佣金
 */
@property (nonatomic, assign) double platformMoney;

	/**
审核状态 0：待审核 1：审核通过 2：拒绝
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopWithdrawRecordModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopWithdrawRecordModel*>*)list;

 +(ShopWithdrawRecordModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopWithdrawRecordModel*) source target:(ShopWithdrawRecordModel*)target;

@end

NS_ASSUME_NONNULL_END
