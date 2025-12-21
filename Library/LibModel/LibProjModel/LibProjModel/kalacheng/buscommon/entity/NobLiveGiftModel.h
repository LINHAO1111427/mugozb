//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
直播礼物表
 */
@interface NobLiveGiftModel : NSObject 


	/**
礼物图标
 */
@property (nonatomic, copy) NSString * gifticon;

	/**
蓝量属性
 */
@property (nonatomic, assign) int magic;

	/**
背包id
 */
@property (nonatomic, assign) int64_t backid;

	/**
礼物排序
 */
@property (nonatomic, assign) int orderno;

	/**
动画链接
 */
@property (nonatomic, copy) NSString * swf;

	/**
幸运礼物中奖赔率（保留3位小数）
 */
@property (nonatomic, assign) double luckOdds;

	/**
礼物积分价格
 */
@property (nonatomic, assign) double needScore;

	/**
礼物类型 0:普通礼物 1:粉丝团(豪华礼物) 2:守护(专属礼物) 3:贵族礼物(特殊礼物) 4:签到礼物 5:幸运礼物
 */
@property (nonatomic, assign) int type;

	/**
血量属性
 */
@property (nonatomic, assign) int blood;

	/**
动画类型 0:是GIF 1:是SVGA）
 */
@property (nonatomic, assign) int swftype;

	/**
礼物名称
 */
@property (nonatomic, copy) NSString * giftname;

	/**
礼物数量
 */
@property (nonatomic, assign) int number;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
幸运礼物中奖概率（保留3位小数）
 */
@property (nonatomic, assign) double luckyPerc;

	/**
礼物金币价格
 */
@property (nonatomic, assign) double needcoin;

	/**
0:未选择 1:选中
 */
@property (nonatomic, assign) int checked;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
当前分页值
 */
@property (nonatomic, assign) int page;

	/**
施法对象 0:默认 1:自己 2:对方
 */
@property (nonatomic, assign) int casting_obj;

	/**
礼物标识 0:普通 1:热门 2:守护
 */
@property (nonatomic, assign) int mark;

	/**
动画时长
 */
@property (nonatomic, assign) double swftime;

	/**
状态 0:显示 1:不显示
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<NobLiveGiftModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<NobLiveGiftModel*>*)list;

 +(NobLiveGiftModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(NobLiveGiftModel*) source target:(NobLiveGiftModel*)target;

@end

NS_ASSUME_NONNULL_END
