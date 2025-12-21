//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
一些文字的字典VO
 */
@interface CfgWordDictionaryVOModel : NSObject 


	/**
文字类型 1:技能文字描述 2:档期描述 3:（邀约）温馨提示 4:预约信息
 */
@property (nonatomic, assign) int wordType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

	/**
内容
 */
@property (nonatomic, copy) NSString * content;

 +(NSMutableArray<CfgWordDictionaryVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgWordDictionaryVOModel*>*)list;

 +(CfgWordDictionaryVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgWordDictionaryVOModel*) source target:(CfgWordDictionaryVOModel*)target;

@end

NS_ASSUME_NONNULL_END
