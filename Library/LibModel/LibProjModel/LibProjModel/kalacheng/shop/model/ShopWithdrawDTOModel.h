//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShopWithdrawRecordModel;
 @class AppUsersCashAccountModel;
NS_ASSUME_NONNULL_BEGIN




/**
商家提现信息
 */
@interface ShopWithdrawDTOModel : NSObject 


	/**
提现金额
 */
@property (nonatomic, assign) double realAmount;

	/**
提现记录
 */
@property (nonatomic, strong) NSMutableArray<ShopWithdrawRecordModel*>* shopWithdrawRecordList;

	/**
佣金比例
 */
@property (nonatomic, assign) double sellRate;

	/**
手续费比例
 */
@property (nonatomic, assign) double service;

	/**
默认账号
 */
@property (strong, nonatomic) AppUsersCashAccountModel* account;

 +(NSMutableArray<ShopWithdrawDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopWithdrawDTOModel*>*)list;

 +(ShopWithdrawDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopWithdrawDTOModel*) source target:(ShopWithdrawDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
