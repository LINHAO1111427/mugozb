//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppLiveChannelModel;
 @class AdminRushToTalkConfigModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP求聊页面数据
 */
@interface ApiPushChatDataModel : NSObject 


	/**
ooo一级分类
 */
@property (nonatomic, strong) NSMutableArray<AppLiveChannelModel*>* appLiveChannelList;

	/**
话费列表
 */
@property (nonatomic, strong) NSMutableArray<AdminRushToTalkConfigModel*>* coinList;

	/**
一对一求聊背景图
 */
@property (nonatomic, copy) NSString * oooAskChat;

 +(NSMutableArray<ApiPushChatDataModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPushChatDataModel*>*)list;

 +(ApiPushChatDataModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiPushChatDataModel*) source target:(ApiPushChatDataModel*)target;

@end

NS_ASSUME_NONNULL_END
