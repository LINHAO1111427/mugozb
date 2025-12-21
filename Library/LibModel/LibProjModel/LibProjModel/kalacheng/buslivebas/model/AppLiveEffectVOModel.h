//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
语音音效包VO
 */
@interface AppLiveEffectVOModel : NSObject 


	/**
音效图片
 */
@property (nonatomic, copy) NSString * effectImg;

	/**
音效url
 */
@property (nonatomic, copy) NSString * effectUrl;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
音效名称
 */
@property (nonatomic, copy) NSString * effectName;

	/**
是否开启 0：不开启 1：开启
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<AppLiveEffectVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiveEffectVOModel*>*)list;

 +(AppLiveEffectVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppLiveEffectVOModel*) source target:(AppLiveEffectVOModel*)target;

@end

NS_ASSUME_NONNULL_END
