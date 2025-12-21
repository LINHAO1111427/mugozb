//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧剧集评论显示的信息VO
 */
@interface TelevisionEpisodeCommentVOModel : NSObject 


	/**
用户财富等级图标
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
用户性别 0：保密 1：男 2：女
 */
@property (nonatomic, assign) int userSex;

	/**
电视剧集评论内容
 */
@property (nonatomic, copy) NSString * comments;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
用户的魅力等级图标
 */
@property (nonatomic, copy) NSString * charmGradeImg;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
用户等级图标
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
用户贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
用户贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户贵族等级图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
被评论用户id
 */
@property (nonatomic, assign) int64_t toUserId;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户年龄
 */
@property (nonatomic, assign) int userAge;

	/**
评论时间(展示)
 */
@property (nonatomic, copy) NSString * addTimeStr;

	/**
被评论的评论id
 */
@property (nonatomic, assign) int64_t toCommentId;

	/**
用户贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
用户主播等级图标
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
评论类型 1：评论 2：回复
 */
@property (nonatomic, assign) int commentType;

	/**
评论id
 */
@property (nonatomic, assign) int64_t commentId;

	/**
被评论用户名称
 */
@property (nonatomic, copy) NSString * toUserName;

 +(NSMutableArray<TelevisionEpisodeCommentVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionEpisodeCommentVOModel*>*)list;

 +(TelevisionEpisodeCommentVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionEpisodeCommentVOModel*) source target:(TelevisionEpisodeCommentVOModel*)target;

@end

NS_ASSUME_NONNULL_END
