//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUsersVideoCommentsModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP动态短视频
 */
@interface ApiUserVideoModel : NSObject 


	/**
评论列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUsersVideoCommentsModel*>* commentList;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
距离(千米)
 */
@property (nonatomic, assign) double distance;

	/**
是否喜欢 0:未喜欢 1:已喜欢
 */
@property (nonatomic, assign) int isLike;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
动态封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
收藏数
 */
@property (nonatomic, assign) int collectNum;

	/**
隐藏发布位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int hidePublishingAddress;

	/**
是否私密 0:正常 1:私密
 */
@property (nonatomic, assign) int isPrivate;

	/**
动态标题
 */
@property (nonatomic, copy) NSString * title;

	/**
类型 0:只有文字 1:视频动态 2:图片动态）
 */
@property (nonatomic, assign) int type;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
动态内容
 */
@property (nonatomic, copy) NSString * content;

	/**
是否个人置顶 0:未置顶 1:已置顶
 */
@property (nonatomic, assign) int personalTop;

	/**
发布时间str
 */
@property (nonatomic, copy) NSString * addtimeStr;

	/**
分享数量
 */
@property (nonatomic, assign) int shares;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
背景音乐id
 */
@property (nonatomic, assign) int musicId;

	/**
视频地址
 */
@property (nonatomic, copy) NSString * href;

	/**
null
 */
@property (nonatomic, assign) int id_field;

	/**
视频时长
 */
@property (nonatomic, copy) NSString * videoTime;

	/**
浏览数量
 */
@property (nonatomic, assign) int views;

	/**
视频高
 */
@property (nonatomic, assign) int height;

	/**
点赞数量
 */
@property (nonatomic, assign) int likes;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
动态图片（逗号拼接）
 */
@property (nonatomic, copy) NSString * images;

	/**
详细地址
 */
@property (nonatomic, copy) NSString * address;

	/**
评论数量
 */
@property (nonatomic, assign) int comments;

	/**
性别 0:保密 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
是否收藏 0:未收藏 1:已收藏
 */
@property (nonatomic, assign) int isCollect;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
是否关注 0:未关注 1:已关注
 */
@property (nonatomic, assign) int isAtt;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
踩数量
 */
@property (nonatomic, assign) int steps;

	/**
是否是贵族发的 0:是 1:否
 */
@property (nonatomic, assign) int isVip;

	/**
是否可分享 1:可以 0:不可用
 */
@property (nonatomic, assign) int isShares;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
话题ID
 */
@property (nonatomic, assign) int64_t topicId;

	/**
发布时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
视频宽
 */
@property (nonatomic, assign) int width;

	/**
等级图片
 */
@property (nonatomic, copy) NSString * gradeImg;

	/**
话题名
 */
@property (nonatomic, copy) NSString * topicName;

	/**
一对一海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
私密动态资源查看所需金币
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<ApiUserVideoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserVideoModel*>*)list;

 +(ApiUserVideoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserVideoModel*) source target:(ApiUserVideoModel*)target;

@end

NS_ASSUME_NONNULL_END
