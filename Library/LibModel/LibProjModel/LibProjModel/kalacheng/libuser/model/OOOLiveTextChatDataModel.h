//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class OOOLiveRoomTextChatDataModel;
NS_ASSUME_NONNULL_BEGIN




/**
1v1文字聊天页面数据
 */
@interface OOOLiveTextChatDataModel : NSObject 


	/**
共同标签(多个用逗号隔开)
 */
@property (nonatomic, copy) NSString * tabList;

	/**
对方城市
 */
@property (nonatomic, copy) NSString * toUserCity;

	/**
隐藏距离 0:不隐藏 1:隐藏
 */
@property (nonatomic, assign) int hideDistance;

	/**
距离(千米)
 */
@property (nonatomic, copy) NSString * distance;

	/**
对方地址
 */
@property (nonatomic, copy) NSString * toUserAddr;

	/**
我和TA的故事
 */
@property (strong, nonatomic) OOOLiveRoomTextChatDataModel* chatData;

	/**
最近是否有发动态 1:发过 0:没有发过
 */
@property (nonatomic, assign) int isVideo;

	/**
最新动态id
 */
@property (nonatomic, assign) int64_t videoId;

 +(NSMutableArray<OOOLiveTextChatDataModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOLiveTextChatDataModel*>*)list;

 +(OOOLiveTextChatDataModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOLiveTextChatDataModel*) source target:(OOOLiveTextChatDataModel*)target;

@end

NS_ASSUME_NONNULL_END
