//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class StarPriceDOModel;
NS_ASSUME_NONNULL_BEGIN




/**
微信号model
 */
@interface CfgWechatVOModel : NSObject 


	/**
微信价格
 */
@property (nonatomic, assign) double wechatPrice;

	/**
微信号
 */
@property (nonatomic, copy) NSString * wechat;

	/**
微信号价格列表
 */
@property (nonatomic, strong) NSMutableArray<StarPriceDOModel*>* wechatPriceList;

 +(NSMutableArray<CfgWechatVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgWechatVOModel*>*)list;

 +(CfgWechatVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgWechatVOModel*) source target:(CfgWechatVOModel*)target;

@end

NS_ASSUME_NONNULL_END
