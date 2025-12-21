//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP互动请求回应响应
 */
@interface ApiSendLineMsgRoomModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
响应状态1同意2拒绝3超时
 */
@property (nonatomic, assign) int status;

	/**
对方房间id
 */
@property (nonatomic, assign) int64_t toRoomId;

	/**
对方用户id
 */
@property (nonatomic, assign) int64_t toUid;

	/**
麦位
 */
@property (nonatomic, assign) int no;

	/**
请求者用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
对方主播头像
 */
@property (nonatomic, copy) NSString * toAvatar;

	/**
对方主播名称
 */
@property (nonatomic, copy) NSString * toName;

	/**
对方的拉流地址
 */
@property (nonatomic, copy) NSString * toPull;

	/**
对方直播封面
 */
@property (nonatomic, copy) NSString * toLiveThumb;

 +(NSMutableArray<ApiSendLineMsgRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendLineMsgRoomModel*>*)list;

 +(ApiSendLineMsgRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSendLineMsgRoomModel*) source target:(ApiSendLineMsgRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
