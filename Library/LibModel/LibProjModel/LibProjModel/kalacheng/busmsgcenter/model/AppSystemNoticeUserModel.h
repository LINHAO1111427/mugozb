//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
app系统通知用户表
 */
@interface AppSystemNoticeUserModel : NSObject 


	/**
创建时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
通知类型
 */
@property (nonatomic, assign) int noticeType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
通知标题
 */
@property (nonatomic, copy) NSString * title;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
通知内容
 */
@property (nonatomic, copy) NSString * content;

	/**
通知id
 */
@property (nonatomic, assign) int64_t noticeId;

	/**
是否已读 0:已读 1:未读
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppSystemNoticeUserModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSystemNoticeUserModel*>*)list;

 +(AppSystemNoticeUserModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSystemNoticeUserModel*) source target:(AppSystemNoticeUserModel*)target;

@end

NS_ASSUME_NONNULL_END
