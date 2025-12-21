//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP连线时弹窗
 */
@interface ApiLineBeforeOOOModel : NSObject 


	/**
弹出费用值
 */
@property (nonatomic, copy) NSString * typeVal;

	/**
是否需要弹出弹窗1需要2不需要
 */
@property (nonatomic, assign) int isPopup;

	/**
弹出内容
 */
@property (nonatomic, copy) NSString * typeDec;

 +(NSMutableArray<ApiLineBeforeOOOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLineBeforeOOOModel*>*)list;

 +(ApiLineBeforeOOOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiLineBeforeOOOModel*) source target:(ApiLineBeforeOOOModel*)target;

@end

NS_ASSUME_NONNULL_END
