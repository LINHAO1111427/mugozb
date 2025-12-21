//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
商家直播预告详情
 */
@interface ShopLiveAnnouncementDetailDTOModel : NSObject 


	/**
是否关注 1:关注 0:未关注
 */
@property (nonatomic, assign) int isAttention;

	/**
直播日期
 */
@property (nonatomic, copy) NSString * liveDate;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
开始时间
 */
@property (nonatomic,copy) NSDate * startTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
主播Id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
海报贴纸
 */
@property (nonatomic, copy) NSString * posterStickers;

	/**
标题
 */
@property (nonatomic, copy) NSString * title;

	/**
直播id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
购物分类
 */
@property (nonatomic, copy) NSString * shopCategory;

 +(NSMutableArray<ShopLiveAnnouncementDetailDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveAnnouncementDetailDTOModel*>*)list;

 +(ShopLiveAnnouncementDetailDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopLiveAnnouncementDetailDTOModel*) source target:(ShopLiveAnnouncementDetailDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
