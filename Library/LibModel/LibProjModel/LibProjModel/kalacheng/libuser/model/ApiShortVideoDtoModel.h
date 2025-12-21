//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ShortVideoAdsVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
短视频首页对象
 */
@interface ApiShortVideoDtoModel : NSObject 


	/**
长视频一级分类id
 */
@property (nonatomic, assign) int64_t longVideoClassifyOne;

	/**
推荐 1:推荐 0:不推荐
 */
@property (nonatomic, assign) int isRecommend;

	/**
付费次数
 */
@property (nonatomic, assign) int fees;

	/**
使用短视频广告模板 0：不启用 1:启用
 */
@property (nonatomic, assign) int isEnableTemplate;

	/**
分类id(多个逗号隔开)
 */
@property (nonatomic, copy) NSString * classifyId;

	/**
是否是长视频 0：不是 1:是
 */
@property (nonatomic, assign) int isLongVideo;

	/**
类型 1:视频 2:图片
 */
@property (nonatomic, assign) int type;

	/**
分享数量
 */
@property (nonatomic, assign) int shareNum;

	/**
商品名称
 */
@property (nonatomic, copy) NSString * productName;

	/**
内部推荐(用于计算排序) 0:不推荐 1:推荐
 */
@property (nonatomic, assign) int internalRecommended;

	/**
数量(列表记录广告间隔次数)
 */
@property (nonatomic, assign) int number;

	/**
观看次数
 */
@property (nonatomic, assign) int looks;

	/**
本周必看 0:是 1:否
 */
@property (nonatomic, assign) int isWeek;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
视频时长(单位秒)
 */
@property (nonatomic, assign) int videoTime;

	/**
分类名称(多个逗号隔开)
 */
@property (nonatomic, copy) NSString * classifyName;

	/**
纬度
 */
@property (nonatomic, assign) double lat;

	/**
封面图高
 */
@property (nonatomic, assign) int height;

	/**
点赞数量
 */
@property (nonatomic, assign) int likes;

	/**
按钮名称
 */
@property (nonatomic, copy) NSString * adsText;

	/**
随机排序数值 年+月+日+随机5位
 */
@property (nonatomic, assign) int64_t randomOrder;

	/**
最低需要特权名称
 */
@property (nonatomic, copy) NSString * privilegesLowestName;

	/**
图片（逗号拼接）
 */
@property (nonatomic, copy) NSString * images;

	/**
广告地址
 */
@property (nonatomic, copy) NSString * adsUrl;

	/**
是否鉴黄 0:未开启 1:鉴黄中 2:鉴黄已通过
 */
@property (nonatomic, assign) int isEnableMonitoring;

	/**
经度
 */
@property (nonatomic, assign) double lng;

	/**
商品id
 */
@property (nonatomic, assign) int64_t productId;

	/**
长视频二级分类id
 */
@property (nonatomic, assign) int64_t longVideoClassifyTwo;

	/**
短视频banner广告
 */
@property (nonatomic, strong) NSMutableArray<ShortVideoAdsVOModel*>* adsBannerList;

	/**
是否关注 1:关注 0:未关注
 */
@property (nonatomic, assign) int isAttention;

	/**
短视频试看时间(秒)
 */
@property (nonatomic, assign) int shortVideoTrialTime;

	/**
私密动态需要的金币
 */
@property (nonatomic, assign) double coin;

	/**
视频状态 0:未审核 1:通过 2:拒绝
 */
@property (nonatomic, assign) int status;

	/**
是否虚拟 1:是 0:不是
 */
@property (nonatomic, assign) int virtualOrNot;

	/**
是否是主播 1:主播 0:用户
 */
@property (nonatomic, assign) int role;

	/**
是否点赞 1:点赞 0:未点赞
 */
@property (nonatomic, assign) int isLike;

	/**
城市
 */
@property (nonatomic, copy) NSString * city;

	/**
封面图
 */
@property (nonatomic, copy) NSString * thumb;

	/**
广告标题
 */
@property (nonatomic, copy) NSString * adsTitle;

	/**
是否私密 0:正常 1:私密
 */
@property (nonatomic, assign) int isPrivate;

	/**
文字内容
 */
@property (nonatomic, copy) NSString * content;

	/**
短视频广告模板id
 */
@property (nonatomic, assign) int64_t adsTemplateId;

	/**
视频地址
 */
@property (nonatomic, copy) NSString * videoUrl;

	/**
短视频头像广告id1
 */
@property (nonatomic, assign) int64_t avatarAdsId1;

	/**
广告类型 0:无 1:用户广告 2:平台广告
 */
@property (nonatomic, assign) int adsType;

	/**
后台页面使用，不用管
 */
@property (nonatomic, assign) int64_t importTemplateId;

	/**
是否删除 1:删除 0:未删除
 */
@property (nonatomic, assign) int isdel;

	/**
图片5
 */
@property (nonatomic, copy) NSString * image5;

	/**
图片6
 */
@property (nonatomic, copy) NSString * image6;

	/**
使用短视频广告模板 0：不启用 1:启用
 */
@property (nonatomic, assign) int isEnableAdsTemplate;

	/**
图片3）
 */
@property (nonatomic, copy) NSString * image3;

	/**
详细地址
 */
@property (nonatomic, copy) NSString * address;

	/**
评论数量
 */
@property (nonatomic, assign) int comments;

	/**
图片4
 */
@property (nonatomic, copy) NSString * image4;

	/**
是否支付 1:已支付 0:未支付
 */
@property (nonatomic, assign) int isPay;

	/**
短视频头像广告
 */
@property (nonatomic, strong) NSMutableArray<ShortVideoAdsVOModel*>* avatarAdsList;

	/**
短视频头像广告id2
 */
@property (nonatomic, assign) int64_t avatarAdsId2;

	/**
短视频轮播图广告id3
 */
@property (nonatomic, assign) int64_t bannerAdsId3;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
短视频头像广告id3
 */
@property (nonatomic, assign) int64_t avatarAdsId3;

	/**
短视频轮播图广告id1
 */
@property (nonatomic, assign) int64_t bannerAdsId1;

	/**
图片1
 */
@property (nonatomic, copy) NSString * image1;

	/**
短视频轮播图广告id2
 */
@property (nonatomic, assign) int64_t bannerAdsId2;

	/**
图片2
 */
@property (nonatomic, copy) NSString * image2;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
发布时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
封面图宽
 */
@property (nonatomic, assign) int width;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiShortVideoDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShortVideoDtoModel*>*)list;

 +(ApiShortVideoDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiShortVideoDtoModel*) source target:(ApiShortVideoDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
