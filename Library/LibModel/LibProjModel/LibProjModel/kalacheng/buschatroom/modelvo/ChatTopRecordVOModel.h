//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天消息中的置顶VO
 */
@interface ChatTopRecordVOModel : NSObject 


	/**
置顶的类型 1:用户 2:家族 3:粉丝团
 */
@property (nonatomic, assign) int topType;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
置顶的用户或群组id(真实)
 */
@property (nonatomic, assign) int64_t topUserOrGorupId;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
置顶的用户或群组ugid
 */
@property (nonatomic, assign) int64_t topUgid;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<ChatTopRecordVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ChatTopRecordVOModel*>*)list;

 +(ChatTopRecordVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ChatTopRecordVOModel*) source target:(ChatTopRecordVOModel*)target;

@end

NS_ASSUME_NONNULL_END
