//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
1v1文字聊天数据
 */
@interface OOOLiveRoomTextChatDataModel : NSObject 


	/**
第一次聊天时间
 */
@property (nonatomic,copy) NSDate * firstTime;

	/**
用户双方发送消息的标志(小的用户id_大的用户id)
 */
@property (nonatomic, copy) NSString * userMsgFlag;

	/**
认识天数
 */
@property (nonatomic, assign) int knowDay;

	/**
对方用户id
 */
@property (nonatomic, assign) int64_t hostUid;

	/**
当前用户id
 */
@property (nonatomic, assign) int64_t feeUid;

	/**
热度
 */
@property (nonatomic, assign) int hotNumber;

	/**
聊天次数
 */
@property (nonatomic, assign) int chatNumber;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<OOOLiveRoomTextChatDataModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOLiveRoomTextChatDataModel*>*)list;

 +(OOOLiveRoomTextChatDataModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOLiveRoomTextChatDataModel*) source target:(OOOLiveRoomTextChatDataModel*)target;

@end

NS_ASSUME_NONNULL_END
