//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 发布短视频code为3时请先认证
*/
@interface AppShortVideo_setShortVideo : NSObject 


 +(AppShortVideo_setShortVideo*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<AppShortVideo_setShortVideo*>*)getFromArr:(NSArray*)list;


	
	/**
详细地址
 */
@property (nonatomic, copy) NSString * address;


	
	/**
城市
 */
@property (nonatomic, copy) NSString * city;


	
	/**
分类ID
 */
@property (nonatomic, copy) NSString * classifyId;


	
	/**
默认0元即可， 填写金币金额
 */
@property (nonatomic, assign) double coin;


	
	/**
文字内容
 */
@property (nonatomic, copy) NSString * content;


	
	/**
封面图高
 */
@property (nonatomic, assign) int height;


	
	/**
视频地址(短视频时才传入)
 */
@property (nonatomic, copy) NSString * href;


	
	/**
图片（逗号拼接）
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
商品id
 */
@property (nonatomic, assign) int64_t productId;


	
	/**
封面图(如果是视频就取第一帧,如果是图片取第一个图片)
 */
@property (nonatomic, copy) NSString * thumb;


	
	/**
类型 1:视频 2:图片
 */
@property (nonatomic, assign) int type;


	
	/**
视频时长（单位秒）
 */
@property (nonatomic, assign) int videoTime;


	
	/**
封面图宽
 */
@property (nonatomic, assign) int width;

@end

NS_ASSUME_NONNULL_END
