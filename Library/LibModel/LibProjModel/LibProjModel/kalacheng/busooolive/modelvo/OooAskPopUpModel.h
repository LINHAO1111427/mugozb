//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP全局求聊弹窗
 */
@interface OooAskPopUpModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
下次执行时间
 */
@property (nonatomic, assign) int64_t nextExecuteDate;

	/**
执行状态 0:正常 1:暂时暂停 2:后台未开启
 */
@property (nonatomic, assign) int executeStatus;

	/**
已发送次数
 */
@property (nonatomic, assign) int toDayNum;

	/**
聊天类型 1:视频聊天 2:语音聊天
 */
@property (nonatomic, assign) int chatType;

	/**
话费id
 */
@property (nonatomic, assign) int64_t feeId;

	/**
一级菜单id
 */
@property (nonatomic, assign) int64_t oooChannelId;

	/**
展示头像
 */
@property (nonatomic, copy) NSString * showAvatar;

	/**
展示标题
 */
@property (nonatomic, copy) NSString * showTitle;

	/**
展示描述
 */
@property (nonatomic, copy) NSString * showDescribe;

 +(NSMutableArray<OooAskPopUpModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooAskPopUpModel*>*)list;

 +(OooAskPopUpModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OooAskPopUpModel*) source target:(OooAskPopUpModel*)target;

@end

NS_ASSUME_NONNULL_END
