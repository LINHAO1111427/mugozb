//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
app端显示的用户特权开关
 */
@interface PrivilegeShowInfoModel : NSObject 


	/**
隐身特权是否开启 0：未开启(app不显示) 1：无特权（点击后提示隐身特权最低等级名称） 2：有特权（允许修改）
 */
@property (nonatomic, assign) int stealthPrivileges;

	/**
全站广播特权是否开启 0：未开启(app不显示) 1：无特权（点击后提示全站广播需要的最低等级名称） 2：有特权（允许修改）
 */
@property (nonatomic, assign) int totalStation;

	/**
全站广播功能 0:关闭 1:开启
 */
@property (nonatomic, assign) int broadCast;

	/**
充值隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int chargeShow;

	/**
全站广播需要的最低等级
 */
@property (nonatomic, copy) NSString * stationLowesGradeName;

	/**
加入房间隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int joinRoomShow;

	/**
隐身特权需要的最低等级名称
 */
@property (nonatomic, copy) NSString * stealthLowesGradeName;

	/**
贡献榜排行隐身 0:不隐身 1:隐身
 */
@property (nonatomic, assign) int devoteShow;

 +(NSMutableArray<PrivilegeShowInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PrivilegeShowInfoModel*>*)list;

 +(PrivilegeShowInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(PrivilegeShowInfoModel*) source target:(PrivilegeShowInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
