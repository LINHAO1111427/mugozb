//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
查看公会正在直播房间信息VO
 */
@interface LiveRoomInfoVOModel : NSObject 


	/**
是否推荐 0:不推荐 1:推荐中
 */
@property (nonatomic, assign) int isRecommend;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
封面
 */
@property (nonatomic, copy) NSString * thumb;

	/**
是否有直播购 0:没有直播购 1:有直播购
 */
@property (nonatomic, assign) int liveFunction;

	/**
类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

	/**
性别 0：保密 1：男， 2女
 */
@property (nonatomic, assign) int sex;

	/**
频道背景图
 */
@property (nonatomic, copy) NSString * channelImage;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
权重排序字段
 */
@property (nonatomic, assign) int sort;

	/**
直播标题
 */
@property (nonatomic, copy) NSString * title;

	/**
安卓用
 */
@property (nonatomic, assign) int isChecked;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
房间ID, 动态之类的无房间：0
 */
@property (nonatomic, assign) int64_t roomId;

	/**
热门分类ID
 */
@property (nonatomic, assign) int64_t hotSortId;

	/**
播流地址
 */
@property (nonatomic, copy) NSString * pull;

	/**
房间标识
 */
@property (nonatomic, copy) NSString * showid;

	/**
类型值(对应类型1视频私密直播2视频收费直播3视频计时直播6 one2one语音7one2one视频11.贵族房间)
 */
@property (nonatomic, copy) NSString * roomTypeVal;

	/**
标签名
 */
@property (nonatomic, copy) NSString * channelName;

	/**
频道ID
 */
@property (nonatomic, assign) int64_t channelId;

	/**
观众人数
 */
@property (nonatomic, assign) int nums;

	/**
房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<LiveRoomInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomInfoVOModel*>*)list;

 +(LiveRoomInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LiveRoomInfoVOModel*) source target:(LiveRoomInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
