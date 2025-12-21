//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商家列表
 */
@interface ShopBusinessModel : NSObject 


	/**
营业执照
 */
@property (nonatomic, copy) NSString * businessLicense;

	/**
剩余可提现金额
 */
@property (nonatomic, assign) double amount;

	/**
已售商品总数量
 */
@property (nonatomic, assign) int totalSoldNum;

	/**
申请时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
商家简介图片地址
 */
@property (nonatomic, copy) NSString * presentPicture;

	/**
联系电话
 */
@property (nonatomic, copy) NSString * mobile;

	/**
资料是否正在审核 1：是 0：否
 */
@property (nonatomic, assign) int materialsReview;

	/**
备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
主播Id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
审核备注
 */
@property (nonatomic, copy) NSString * auditRemake;

	/**
总收益金额
 */
@property (nonatomic, assign) double totalAmount;

	/**
审核时间
 */
@property (nonatomic,copy) NSDate * auditTime;

	/**
商家名称
 */
@property (nonatomic, copy) NSString * name;

	/**
累计提现金额
 */
@property (nonatomic, assign) double totalCash;

	/**
商家LOGO
 */
@property (nonatomic, copy) NSString * logo;

	/**
状态文字描述
 */
@property (nonatomic, copy) NSString * statusRemake;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
商家简介
 */
@property (nonatomic, copy) NSString * present;

	/**
已上架商品数量
 */
@property (nonatomic, assign) int effectiveGoodsNum;

	/**
审核状态 0：未申请 1：审核中 2:审核通过 3:审核拒绝 4:冻结
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ShopBusinessModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessModel*>*)list;

 +(ShopBusinessModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopBusinessModel*) source target:(ShopBusinessModel*)target;

@end

NS_ASSUME_NONNULL_END
