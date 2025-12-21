//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class TraceBeanModel;
NS_ASSUME_NONNULL_BEGIN




/**
物流信息
 */
@interface LogisticsBeanModel : NSObject 


	/**
null
 */
@property (nonatomic, copy) NSString * msg;

	/**
快递公司名称
 */
@property (nonatomic, copy) NSString * expName;

	/**
发货到收货消耗时长 (截止最新轨迹)
 */
@property (nonatomic, copy) NSString * takeTime;

	/**
快递公司电话
 */
@property (nonatomic, copy) NSString * expPhone;

	/**
快递公司官网
 */
@property (nonatomic, copy) NSString * expSite;

	/**
快递轨迹信息最新时间
 */
@property (nonatomic, copy) NSString * updateTime;

	/**
快递物流信息
 */
@property (nonatomic, strong) NSMutableArray<TraceBeanModel*>* list;

	/**
快递公司简称
 */
@property (nonatomic, copy) NSString * type;

	/**
1.签收 0.未签收
 */
@property (nonatomic, copy) NSString * issign;

	/**
单号
 */
@property (nonatomic, copy) NSString * number;

	/**
快递员 或 快递站(没有则为空)
 */
@property (nonatomic, copy) NSString * courier;

	/**
0：快递收件(揽件)1.在途中 2.正在派件 3.已签收 4.派送失败 5.疑难件 6.退件签收
 */
@property (nonatomic, copy) NSString * deliverystatus;

	/**
快递员电话 (没有则为空)
 */
@property (nonatomic, copy) NSString * courierPhone;

	/**
快递公司LOGO
 */
@property (nonatomic, copy) NSString * logo;

	/**
快递状态 0:正常查询 201:快递单号错误 203:快递公司不存在 204:快递公司识别失败 205:没有信息 207:该单号被限制，错误单号
 */
@property (nonatomic, copy) NSString * status;

 +(NSMutableArray<LogisticsBeanModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LogisticsBeanModel*>*)list;

 +(LogisticsBeanModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LogisticsBeanModel*) source target:(LogisticsBeanModel*)target;

@end

NS_ASSUME_NONNULL_END
