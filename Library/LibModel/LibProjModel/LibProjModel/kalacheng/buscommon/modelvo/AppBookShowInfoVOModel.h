//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天通讯录中的显示信息
 */
@interface AppBookShowInfoVOModel : NSObject 


	/**
性别 0:保密 1:男 2:女
 */
@property (nonatomic, assign) int userSex;

	/**
群组类型 1:用户 2:家族 3:粉丝团
 */
@property (nonatomic, assign) int groupType;

	/**
展示的名称(用户名或群组名)
 */
@property (nonatomic, copy) NSString * showName;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int64_t liveType;

	/**
聊天消息置顶时的id(主要用户置顶删除)
 */
@property (nonatomic, assign) int topId;

	/**
展示的描述(个性签名)
 */
@property (nonatomic, copy) NSString * showWord;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
用户年龄
 */
@property (nonatomic, assign) int userAge;

	/**
用户或群组id(没有经过计算的id)
 */
@property (nonatomic, assign) int64_t userOrGroupId;

	/**
置顶时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
是否置顶 0:没有置顶 1:置顶中
 */
@property (nonatomic, assign) int isTop;

	/**
角色 0:普通用户 1:主播用户
 */
@property (nonatomic, assign) int userRole;

	/**
展示的图片(头像或群组头像)
 */
@property (nonatomic, copy) NSString * showIcon;

 +(NSMutableArray<AppBookShowInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppBookShowInfoVOModel*>*)list;

 +(AppBookShowInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppBookShowInfoVOModel*) source target:(AppBookShowInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
