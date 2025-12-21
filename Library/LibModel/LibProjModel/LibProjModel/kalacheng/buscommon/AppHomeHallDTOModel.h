//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
首页大厅数据
 */
@interface AppHomeHallDTOModel : NSObject 


	/**
是否推荐 0:不推荐 1:推荐中
 */
@property (nonatomic, assign) int isRecommend;

	/**
主播等级
 */
@property (nonatomic, assign) int anchorGrade;

	/**
用户在线状态 0:离线 1:在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
短视频/图片 是否付费：1已支付，0未支付
 */
@property (nonatomic, assign) int dspPay;

	/**
试看时长(0为没有试看时间了)
 */
@property (nonatomic, assign) int freeWatchTime;

	/**
二级频道id
 */
@property (nonatomic, assign) int64_t twoClassifyId;

	/**
贵族图标
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户设置的在线状态 0:在线 1:忙碌 2:离开 3:通话中
 */
@property (nonatomic, assign) int userSetOnlineStatus;

	/**
房间ID, 动态之类的无房间：0
 */
@property (nonatomic, assign) int64_t roomId;

	/**
点赞数
 */
@property (nonatomic, assign) int likeNum;

	/**
房间状态 1：开启 0：关闭
 */
@property (nonatomic, assign) int roomStatus;

	/**
直播状态 1：正在直播 2：关播
 */
@property (nonatomic, assign) int isLive;

	/**
排序字段(后台使用)
 */
@property (nonatomic, assign) int ul;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
经度
 */
@property (nonatomic, assign) double lat;

	/**
视频直播状态:0:未进行直播 1:直播中的主播 2:直播中的观众
 */
@property (nonatomic, assign) int liveStatus;

	/**
观众人数
 */
@property (nonatomic, assign) int nums;

	/**
房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 */
@property (nonatomic, assign) int roomType;

	/**
身高（CM）
 */
@property (nonatomic, assign) int height;

	/**
类型值(对应类型1视频私密直播2视频收费直播3视频计时直播6 one2one语音7one2one视频11.贵族房间)
 */
@property (nonatomic, copy) NSString * typeVal;

	/**
频道名称（以前 一对一存的是 用户兴趣标签，其他类型没有存）
 */
@property (nonatomic, copy) NSString * tabName;

	/**
svip图标
 */
@property (nonatomic, copy) NSString * svipIcon;

	/**
头像
 */
@property (nonatomic, copy) NSString * headImg;

	/**
纬度
 */
@property (nonatomic, assign) double lng;

	/**
是否有直播购 0:没有直播购 1:有直播购
 */
@property (nonatomic, assign) int liveFunction;

	/**
体重（KG）
 */
@property (nonatomic, assign) double weight;

	/**
隐藏位置 0:未开启 1:开启
 */
@property (nonatomic, assign) int whetherEnablePositioningShow;

	/**
权重排序字段
 */
@property (nonatomic, assign) int sort;

	/**
安卓用
 */
@property (nonatomic, assign) int isChecked;

	/**
评论数
 */
@property (nonatomic, assign) int commentNum;

	/**
热门分类ID
 */
@property (nonatomic, assign) int64_t hotSortId;

	/**
一对一语音地址
 */
@property (nonatomic, copy) NSString * oooVoice;

	/**
资源类型：0:视频一般直播 1:视频私密直播 2:视频收费直播 3:视频计时直播 4:语音普通直播 5:语音私密直播 6:one2one语音 7:one2one视频 8:文字动态 9:视频动态 10:图片动态 11:多人直播贵族房间 12:短视频 13:短视频图片 14:直播购 15:语音付费 16:语音贵族 17:语音计时
 */
@property (nonatomic, assign) int sourceType;

	/**
离线时间
 */
@property (nonatomic,copy) NSDate * lastOffLineTime;

	/**
位置
 */
@property (nonatomic, copy) NSString * position;

	/**
资源封面
 */
@property (nonatomic, copy) NSString * sourceCover;

	/**
svip 0:不是 1:是 
 */
@property (nonatomic, assign) int isSvip;

	/**
金币 包含付费金币，以及计时付费金币  
 */
@property (nonatomic, assign) double coin;

	/**
主播等级ICON
 */
@property (nonatomic, copy) NSString * anchorGradeIcon;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
距离(千米)
 */
@property (nonatomic, copy) NSString * distance;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

	/**
视频价格
 */
@property (nonatomic, assign) double videoCoin;

	/**
短视频/图片 是否私密：0：正常 1私密
 */
@property (nonatomic, assign) int isPrivate;

	/**
直播标题
 */
@property (nonatomic, copy) NSString * title;

	/**
类型描述
 */
@property (nonatomic, copy) NSString * typeDec;

	/**
语音价格
 */
@property (nonatomic, assign) double voiceCoin;

	/**
火力值
 */
@property (nonatomic, assign) double fireVale;

	/**
一对一直播状态:0:未进行直播 1:通话中 2:邀请他人通话 3:正在被邀请
 */
@property (nonatomic, assign) int oooLiveStatus;

	/**
展示声音时长
 */
@property (nonatomic, assign) int64_t voiceTime;

	/**
频道ID
 */
@property (nonatomic, assign) int64_t channelId;

	/**
注册时间
 */
@property (nonatomic,copy) NSDate * createDate;

	/**
一对一视频封面地址
 */
@property (nonatomic, copy) NSString * oooVideoImg;

	/**
一对一视频地址
 */
@property (nonatomic, copy) NSString * oooVideo;

	/**
隐藏距离 0:不隐藏 1:隐藏
 */
@property (nonatomic, assign) int hideDistance;

	/**
门票房间是否需要付费 0:不需要付费 1:需要付费
 */
@property (nonatomic, assign) int isPay;

	/**
性别 0：保密 1：男， 2女
 */
@property (nonatomic, assign) int sex;

	/**
商家头像
 */
@property (nonatomic, copy) NSString * businessLogo;

	/**
频道背景图
 */
@property (nonatomic, copy) NSString * channelImage;

	/**
当日收益
 */
@property (nonatomic, assign) double todayIncome;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
播流地址
 */
@property (nonatomic, copy) NSString * pull;

	/**
房间标识
 */
@property (nonatomic, copy) NSString * showid;

	/**
资源状态 所有直播类型资源：0关播， 1：直播 2:忙碌中  动态类型默认全部是1（一对一时:0在线1忙碌2离开3通话中）
 */
@property (nonatomic, assign) int sourceState;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<AppHomeHallDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeHallDTOModel*>*)list;

 +(AppHomeHallDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeHallDTOModel*) source target:(AppHomeHallDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
