//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
充值礼包
 */
@interface GiftPackVOModel : NSObject 


	/**
礼物图标(贵族图标)
 */
@property (nonatomic, copy) NSString * gifticon;

	/**
类型值 个数天数
 */
@property (nonatomic, assign) int typeVal;

	/**
奖励名称
 */
@property (nonatomic, copy) NSString * name;

	/**
奖励项目 coin：金币 gift：礼物 car：坐骑 video：短视频 noble：贵族 laScore:恋爱积分
 */
@property (nonatomic, copy) NSString * action;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
奖励类型
 */
@property (nonatomic, assign) int64_t type;

 +(NSMutableArray<GiftPackVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftPackVOModel*>*)list;

 +(GiftPackVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GiftPackVOModel*) source target:(GiftPackVOModel*)target;

@end

NS_ASSUME_NONNULL_END
