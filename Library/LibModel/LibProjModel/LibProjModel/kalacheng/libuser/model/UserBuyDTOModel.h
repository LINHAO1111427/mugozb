//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户下单信息
 */
@interface UserBuyDTOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * goodsName;

 +(NSMutableArray<UserBuyDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserBuyDTOModel*>*)list;

 +(UserBuyDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserBuyDTOModel*) source target:(UserBuyDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
