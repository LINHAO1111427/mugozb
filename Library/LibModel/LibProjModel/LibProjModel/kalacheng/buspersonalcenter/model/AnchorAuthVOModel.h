//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class UserInterestTabVOModel;
 @class AnchorAuthDOModel;
 @class TabTypeDtoModel;
 @class StarPriceDOModel;
 @class AppLiveChannelModel;
 @class PayCallOneVsOneDOModel;
NS_ASSUME_NONNULL_BEGIN




/**
主播认证信息
 */
@interface AnchorAuthVOModel : NSObject 


	/**
生日
 */
@property (nonatomic, copy) NSString * birthday;

	/**
我的兴趣标签列表展示
 */
@property (nonatomic, strong) NSMutableArray<UserInterestTabVOModel*>* myInterestList;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
微信号价格
 */
@property (nonatomic, assign) double wechatPrice;

	/**
是否显示列表
 */
@property (nonatomic, strong) NSMutableArray<AnchorAuthDOModel*>* auchorAuthShowList;

	/**
一对一 二级分类id
 */
@property (nonatomic, assign) int64_t oooTwoClassifyId;

	/**
身份证号
 */
@property (nonatomic, copy) NSString * cerNo;

	/**
星座
 */
@property (nonatomic, copy) NSString * constellation;

	/**
身份证反面照片
 */
@property (nonatomic, copy) NSString * idCardBackView;

	/**
身高
 */
@property (nonatomic, assign) int height;

	/**
兴趣标签列表
 */
@property (nonatomic, strong) NSMutableArray<TabTypeDtoModel*>* interestList;

	/**
一对一 一级分类id
 */
@property (nonatomic, assign) int64_t oooOneClassifyId;

	/**
视频费用列表
 */
@property (nonatomic, strong) NSMutableArray<StarPriceDOModel*>* videoPriceList;

	/**
昵称
 */
@property (nonatomic, copy) NSString * nickName;

	/**
性别：1男，2女
 */
@property (nonatomic, assign) int sex;

	/**
微信号
 */
@property (nonatomic, copy) NSString * wechat;

	/**
视频认证
 */
@property (nonatomic, copy) NSString * videoAuth;

	/**
体重
 */
@property (nonatomic, assign) double weight;

	/**
一对一一级分类列表
 */
@property (nonatomic, strong) NSMutableArray<AppLiveChannelModel*>* oooOneClassifyList;

	/**
一对一设置
 */
@property (strong, nonatomic) PayCallOneVsOneDOModel* payCall;

	/**
身份证正面照片
 */
@property (nonatomic, copy) NSString * idCardFrontView;

	/**
职业
 */
@property (nonatomic, copy) NSString * vocation;

	/**
真实姓名
 */
@property (nonatomic, copy) NSString * realName;

	/**
三围
 */
@property (nonatomic, copy) NSString * sanwei;

	/**
手持身份证照片
 */
@property (nonatomic, copy) NSString * idCardHandView;

	/**
语音费用列表
 */
@property (nonatomic, strong) NSMutableArray<StarPriceDOModel*>* voicePriceList;

	/**
附加信息
 */
@property (nonatomic, copy) NSString * remarks;

	/**
微信号价格列表
 */
@property (nonatomic, strong) NSMutableArray<StarPriceDOModel*>* wechatPriceList;

 +(NSMutableArray<AnchorAuthVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorAuthVOModel*>*)list;

 +(AnchorAuthVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AnchorAuthVOModel*) source target:(AnchorAuthVOModel*)target;

@end

NS_ASSUME_NONNULL_END
