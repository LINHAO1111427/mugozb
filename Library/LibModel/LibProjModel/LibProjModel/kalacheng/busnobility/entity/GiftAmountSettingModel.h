//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
送礼物数量设置
 */
@interface GiftAmountSettingModel : NSObject 


	/**
序号
 */
@property (nonatomic, assign) int serialNumber;

	/**
送礼物数量描述(最多5个汉字)
 */
@property (nonatomic, copy) NSString * numberDescription;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
送礼物数量
 */
@property (nonatomic, assign) int numberOfGifts;

	/**
更新时间
 */
@property (nonatomic,copy) NSDate * updateTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<GiftAmountSettingModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftAmountSettingModel*>*)list;

 +(GiftAmountSettingModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GiftAmountSettingModel*) source target:(GiftAmountSettingModel*)target;

@end

NS_ASSUME_NONNULL_END
