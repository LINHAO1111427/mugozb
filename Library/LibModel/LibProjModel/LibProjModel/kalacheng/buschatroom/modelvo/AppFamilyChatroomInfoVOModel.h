//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppChatFamilyMsgTopVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
聊天家族消息置顶VO
 */
@interface AppFamilyChatroomInfoVOModel : NSObject 


	/**
广场禁言特权 0：没有 1：有
 */
@property (nonatomic, assign) int isSquareMute;

	/**
贡献榜第一名头像(日榜)
 */
@property (nonatomic, copy) NSString * contributionFirstAvatar;

	/**
最公告是否看过 0：没看过 1：已看过
 */
@property (nonatomic, assign) int isShowProclamation;

	/**
族长贵族头像框
 */
@property (nonatomic, copy) NSString * patriarchNobleAvatarFrame;

	/**
实时人数 
 */
@property (nonatomic, assign) int64_t realTimeNumber;

	/**
置顶消息消耗的金币
 */
@property (nonatomic, assign) double sendTopMsgCoin;

	/**
家族图标
 */
@property (nonatomic, copy) NSString * familyIcon;

	/**
族长年龄
 */
@property (nonatomic, assign) int patriarchAge;

	/**
族长名称
 */
@property (nonatomic, copy) NSString * patriarchName;

	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
族长性别 0:未设置 1:男 2:女
 */
@property (nonatomic, assign) int patriarchSex;

	/**
族长等级图片
 */
@property (nonatomic, copy) NSString * patriarchGradeImg;

	/**
置顶消息
 */
@property (strong, nonatomic) AppChatFamilyMsgTopVOModel* appChatFamilyMsgTopVO;

	/**
家族名称
 */
@property (nonatomic, copy) NSString * familyName;

	/**
家族人数 
 */
@property (nonatomic, assign) int familyNumber;

	/**
族长头像
 */
@property (nonatomic, copy) NSString * patriarchAvatar;

	/**
族长id
 */
@property (nonatomic, assign) int64_t patriarchId;

	/**
家族等级
 */
@property (nonatomic, assign) int familyGrade;

	/**
家族来源 1：用户申请 2：后台添加
 */
@property (nonatomic, assign) int familyFrom;

	/**
家族公告（对内）
 */
@property (nonatomic, copy) NSString * familyProclamation;

	/**
置顶消息需要的积分
 */
@property (nonatomic, assign) double sendTopMsgScore;

 +(NSMutableArray<AppFamilyChatroomInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppFamilyChatroomInfoVOModel*>*)list;

 +(AppFamilyChatroomInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppFamilyChatroomInfoVOModel*) source target:(AppFamilyChatroomInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
