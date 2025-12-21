//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP给用户发送消息
 */
@interface ApiSendMsgUserModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

	/**
连麦倒计时
 */
@property (nonatomic, assign) int line_time;

	/**
大头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
房间类型0是一般直播，1是私密直播
 */
@property (nonatomic, assign) int type;

	/**
会话ID,用于连麦、互动、PK的整个过程
 */
@property (nonatomic, assign) int64_t sessionID;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

 +(NSMutableArray<ApiSendMsgUserModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendMsgUserModel*>*)list;

 +(ApiSendMsgUserModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSendMsgUserModel*) source target:(ApiSendMsgUserModel*)target;

@end

NS_ASSUME_NONNULL_END
