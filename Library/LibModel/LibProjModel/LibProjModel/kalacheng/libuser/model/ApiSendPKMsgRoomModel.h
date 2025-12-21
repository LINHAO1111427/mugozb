//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP互动请求回应响应
 */
@interface ApiSendPKMsgRoomModel : NSObject 


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
对方的拉流地址
 */
@property (nonatomic, copy) NSString * toPull;

	/**
直播封面
 */
@property (nonatomic, copy) NSString * toLiveThumb;

	/**
PK时长
 */
@property (nonatomic, assign) int pkTime;

 +(NSMutableArray<ApiSendPKMsgRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendPKMsgRoomModel*>*)list;

 +(ApiSendPKMsgRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSendPKMsgRoomModel*) source target:(ApiSendPKMsgRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
