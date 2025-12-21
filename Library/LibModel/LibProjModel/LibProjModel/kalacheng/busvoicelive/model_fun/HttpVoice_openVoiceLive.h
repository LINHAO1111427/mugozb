//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * http方式创建房间code为3时请先认证
*/
@interface HttpVoice_openVoiceLive : NSObject 


 +(HttpVoice_openVoiceLive*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<HttpVoice_openVoiceLive*>*)getFromArr:(NSArray*)list;


	
	/**
主播地址
 */
@property (nonatomic, copy) NSString * addr;


	
	/**
频道ID
 */
@property (nonatomic, assign) int64_t channelId;


	
	/**
市
 */
@property (nonatomic, copy) NSString * city;


	
	/**
纬度
 */
@property (nonatomic, assign) double lat;


	
	/**
经度
 */
@property (nonatomic, assign) double lng;


	
	/**
直播云推/拉流地址
 */
@property (nonatomic, copy) NSString * pull;


	
	/**
房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;


	
	/**
房间模式对应的值 密码房间：密码  收费房间：收费金额
 */
@property (nonatomic, copy) NSString * roomTypeVal;


	
	/**
开播标题
 */
@property (nonatomic, copy) NSString * title;


	
	/**
自动上麦状态 1:开 0:关
 */
@property (nonatomic, assign) int upStatus;

@end

NS_ASSUME_NONNULL_END
