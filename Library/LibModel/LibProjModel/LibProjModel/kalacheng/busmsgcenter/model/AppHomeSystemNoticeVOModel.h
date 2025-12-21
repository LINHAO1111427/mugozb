//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
app系统通知VO
 */
@interface AppHomeSystemNoticeVOModel : NSObject 


	/**
新消息时间
 */
@property (nonatomic, copy) NSString * addtimeStr;

	/**
未读数
 */
@property (nonatomic, assign) int noReadNumber;

	/**
添加消息的时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
通知标题(前端展示)
 */
@property (nonatomic, copy) NSString * showTitle;

	/**
最新一条消息内容(前端展示)
 */
@property (nonatomic, copy) NSString * firstMsg;

	/**
logo
 */
@property (nonatomic, copy) NSString * logo;

	/**
通知类型
 */
@property (nonatomic, assign) int64_t noticeType;

	/**
通知标题
 */
@property (nonatomic, copy) NSString * title;

	/**
通知id
 */
@property (nonatomic, assign) int64_t noticeId;

 +(NSMutableArray<AppHomeSystemNoticeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeSystemNoticeVOModel*>*)list;

 +(AppHomeSystemNoticeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeSystemNoticeVOModel*) source target:(AppHomeSystemNoticeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
