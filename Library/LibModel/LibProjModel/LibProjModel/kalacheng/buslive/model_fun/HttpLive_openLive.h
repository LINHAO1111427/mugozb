//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * http方式创建房间code为3时请先认证
*/
@interface HttpLive_openLive : NSObject 


 +(HttpLive_openLive*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<HttpLive_openLive*>*)getFromArr:(NSArray*)list;


	
	/**
开播地址
 */
@property (nonatomic, copy) NSString * address;


	
	/**
频道id
 */
@property (nonatomic, assign) int channelId;


	
	/**
市
 */
@property (nonatomic, copy) NSString * city;


	
	/**
经度
 */
@property (nonatomic, assign) double lat;


	
	/**
是否有直播购 0:没有直播购 1:有直播购
 */
@property (nonatomic, assign) int liveFunction;


	
	/**
纬度
 */
@property (nonatomic, assign) double lng;


	
	/**
省
 */
@property (nonatomic, copy) NSString * province;


	
	/**
播流地址
 */
@property (nonatomic, copy) NSString * pull;


	
	/**
房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 */
@property (nonatomic, assign) int roomType;


	
	/**
房间类型对应的值
 */
@property (nonatomic, copy) NSString * roomTypeVal;


	
	/**
直播购房间标签
 */
@property (nonatomic, copy) NSString * shopRoomLabel;


	
	/**
开播标题
 */
@property (nonatomic, copy) NSString * title;

@end

NS_ASSUME_NONNULL_END
