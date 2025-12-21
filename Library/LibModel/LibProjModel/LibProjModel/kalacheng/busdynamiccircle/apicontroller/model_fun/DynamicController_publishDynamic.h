//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 发布动态(新)code为3时请先认证
*/
@interface DynamicController_publishDynamic : NSObject 


 +(DynamicController_publishDynamic*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<DynamicController_publishDynamic*>*)getFromArr:(NSArray*)list;


	
	/**
详细地址
 */
@property (nonatomic, copy) NSString * address;


	
	/**
频道id
 */
@property (nonatomic, assign) int64_t channelId;


	
	/**
城市
 */
@property (nonatomic, copy) NSString * city;


	
	/**
默认0元即可， 填写金币金额
 */
@property (nonatomic, assign) double coin;


	
	/**
动态内容
 */
@property (nonatomic, copy) NSString * content;


	
	/**
视频高
 */
@property (nonatomic, assign) int height;


	
	/**
隐藏发布位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int hidePublishingAddress;


	
	/**
视频地址(视频类型时才传入)
 */
@property (nonatomic, copy) NSString * href;


	
	/**
动态图片（逗号拼接）
 */
@property (nonatomic, copy) NSString * images;


	
	/**
是否私密 0：正常 1：私密
 */
@property (nonatomic, assign) int isPrivate;


	
	/**
纬度
 */
@property (nonatomic, assign) double lat;


	
	/**
经度
 */
@property (nonatomic, assign) double lng;


	
	/**
音乐id
 */
@property (nonatomic, assign) int64_t musicId;


	
	/**
资源来源 1:首页发布动态 2:其他地方发布出来的动态
 */
@property (nonatomic, assign) int sourceFrom;


	
	/**
动态封面图
 */
@property (nonatomic, copy) NSString * thumb;


	
	/**
动态标题
 */
@property (nonatomic, copy) NSString * title;


	
	/**
动态话题ID
 */
@property (nonatomic, assign) int64_t topicId;


	
	/**
类型 0:只有文字 1:视频动态 2:图片动态
 */
@property (nonatomic, assign) int type;


	
	/**
视频时长
 */
@property (nonatomic, copy) NSString * videoTime;


	
	/**
视频宽
 */
@property (nonatomic, assign) int width;

@end

NS_ASSUME_NONNULL_END
