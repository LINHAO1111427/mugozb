//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
后台一对一配置VO(app端使用)
 */
@interface OooLiveConfigVOModel : NSObject 


	/**
1v1是否评论开关 0:开启 1:关闭
 */
@property (nonatomic, assign) int isComment;

	/**
直播间查看主播联系方式
 */
@property (nonatomic, assign) int takeAnchorContact;

	/**
私信查看主播联系方式
 */
@property (nonatomic, assign) int chatRoomAnchorContact;

	/**
首页默认大小图切换 0:大图 1:小图
 */
@property (nonatomic, assign) int homePageSwitch;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
个人主页查看主播联系方式
 */
@property (nonatomic, assign) int homeAnchorContact;

 +(NSMutableArray<OooLiveConfigVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooLiveConfigVOModel*>*)list;

 +(OooLiveConfigVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OooLiveConfigVOModel*) source target:(OooLiveConfigVOModel*)target;

@end

NS_ASSUME_NONNULL_END
