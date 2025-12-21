//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppCommonWordsModel;
NS_ASSUME_NONNULL_BEGIN




/**
常用语 提示
 */
@interface CommonTipsDTOModel : NSObject 


	/**
私聊扣费提示语
 */
@property (nonatomic, copy) NSString * privateChatDeductionTips;

	/**
私聊是否扣费(是否显示提示语) 1：扣费 0：不扣费
 */
@property (nonatomic, assign) int isShowTips;

	/**
聊天常用语 集合
 */
@property (nonatomic, strong) NSMutableArray<AppCommonWordsModel*>* commonWordsList;

 +(NSMutableArray<CommonTipsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CommonTipsDTOModel*>*)list;

 +(CommonTipsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CommonTipsDTOModel*) source target:(CommonTipsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
