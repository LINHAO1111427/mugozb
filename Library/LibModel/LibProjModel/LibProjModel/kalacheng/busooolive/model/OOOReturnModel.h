//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class OTMAssisRetModel;
NS_ASSUME_NONNULL_BEGIN




/**
一对一返回
 */
@interface OOOReturnModel : NSObject 


	/**
主播（副播）显示的地址
 */
@property (nonatomic, copy) NSString * anchorShowAddr;

	/**
免费通话提示信息
 */
@property (nonatomic, copy) NSString * freeCallMsg;

	/**
直播间推送警告内容
 */
@property (nonatomic, copy) NSString * noticeMsg;

	/**
房间用户集合
 */
@property (nonatomic, strong) NSMutableArray<OTMAssisRetModel*>* otmAssisRetList;

	/**
主持人id
 */
@property (nonatomic, assign) int64_t hostId;

	/**
是否为视频通话 1:视频 0:语音
 */
@property (nonatomic, assign) int isVideo;

	/**
会话ID
 */
@property (nonatomic, assign) int64_t sessionID;

	/**
送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:群聊礼物 9:短视频
 */
@property (nonatomic, assign) int type;

	/**
消费者id
 */
@property (nonatomic, assign) int64_t feeId;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
直播标识
 */
@property (nonatomic, copy) NSString * showid;

	/**
(付费方)免费通话时长
 */
@property (nonatomic, assign) int freeCallDuration;

	/**
是否付费通话 0:不付费 1:付费
 */
@property (nonatomic, assign) int whetherToPay;

	/**
类型 1:一对一正常通话 2:抢聊通话
 */
@property (nonatomic, assign) int m_type;

	/**
主播（副播）显示的城市
 */
@property (nonatomic, copy) NSString * anchorShowCity;

 +(NSMutableArray<OOOReturnModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOReturnModel*>*)list;

 +(OOOReturnModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOReturnModel*) source target:(OOOReturnModel*)target;

@end

NS_ASSUME_NONNULL_END
