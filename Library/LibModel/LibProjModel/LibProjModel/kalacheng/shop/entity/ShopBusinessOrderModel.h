//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商家订单表
 */
@interface ShopBusinessOrderModel : NSObject 


	/**
申请退款原因
 */
@property (nonatomic, copy) NSString * reason;

	/**
发货物流id
 */
@property (nonatomic, assign) int64_t logisticsId;

	/**
人工退款金额
 */
@property (nonatomic, assign) double manualRefundMoney;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商家id
 */
@property (nonatomic, assign) int64_t businessId;

	/**
商家名称
 */
@property (nonatomic, copy) NSString * businessName;

	/**
申请退款审核不通过原因
 */
@property (nonatomic, copy) NSString * auditFailureReason;

	/**
订单号
 */
@property (nonatomic, copy) NSString * orderNum;

	/**
退款订单号
 */
@property (nonatomic, copy) NSString * refundOrderNum;

	/**
收货人手机号
 */
@property (nonatomic, copy) NSString * phoneNum;

	/**
交易成功时间
 */
@property (nonatomic,copy) NSDate * transactionTime;

	/**
收货人地址id
 */
@property (nonatomic, assign) int64_t addressId;

	/**
退款类型 1.仅退款 2.退货退款
 */
@property (nonatomic, assign) int refundType;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
订单金额
 */
@property (nonatomic, assign) double orderAmount;

	/**
退货物流id
 */
@property (nonatomic, assign) int64_t refundLogisticsId;

	/**
人工退款操作人
 */
@property (nonatomic, copy) NSString * manualRefundOperator;

	/**
交易金额(实付金额)
 */
@property (nonatomic, assign) double transactionAmount;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
收货人地址
 */
@property (nonatomic, copy) NSString * address;

	/**
退款完成时间
 */
@property (nonatomic,copy) NSDate * refundTime;

	/**
商家logo
 */
@property (nonatomic, copy) NSString * businessLogo;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
用户支付订单号（平台的）
 */
@property (nonatomic, copy) NSString * platformPayOrder;

	/**
订单来源id
 */
@property (nonatomic, assign) int64_t goodsChannelId;

	/**
退货订单状态 1:待审核 2:待发货 3:待收货 4:退款中 5:退款完成 6:退款失败 7:审核拒绝
 */
@property (nonatomic, assign) int quitStatus;

	/**
人工退款方式 1:支付宝 2:微信 3:人工转账
 */
@property (nonatomic, assign) int manualRefundType;

	/**
退款备注图片
 */
@property (nonatomic, copy) NSString * refundNotesImages;

	/**
是否人工退款 1：是 2：否
 */
@property (nonatomic, assign) int isManualRefund;

	/**
收货人姓名
 */
@property (nonatomic, copy) NSString * name;

	/**
申请退款备注
 */
@property (nonatomic, copy) NSString * refundNotes;

	/**
父订单id
 */
@property (nonatomic, assign) int64_t payId;

	/**
任务id
 */
@property (nonatomic, assign) int64_t taskId;

	/**
订单状态 1:待付款 2:待发货 3:待收货 4:订单完成 5:已取消
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopBusinessOrderModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessOrderModel*>*)list;

 +(ShopBusinessOrderModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopBusinessOrderModel*) source target:(ShopBusinessOrderModel*)target;

@end

NS_ASSUME_NONNULL_END
