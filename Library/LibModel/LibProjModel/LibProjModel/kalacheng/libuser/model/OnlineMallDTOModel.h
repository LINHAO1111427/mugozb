//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppLiangModel;
 @class AppMicSeatBorderVOModel;
 @class AppCarModel;
NS_ASSUME_NONNULL_BEGIN




/**
在线商城
 */
@interface OnlineMallDTOModel : NSObject 


	/**
null
 */
@property (nonatomic, strong) NSMutableArray<AppLiangModel*>* liangList;

	/**
商城内科学计数转换
 */
@property (nonatomic, copy) NSString * coinShow;

	/**
币种名称：钻石
 */
@property (nonatomic, copy) NSString * vcUnit;

	/**
是否是贵族 0:不是 1:是
 */
@property (nonatomic, assign) int vipType;

	/**
null
 */
@property (nonatomic, strong) NSMutableArray<AppMicSeatBorderVOModel*>* seatList;

	/**
图像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
null
 */
@property (nonatomic, strong) NSMutableArray<AppCarModel*>* carList;

	/**
是否有语音模块, 返回h5页面数据，控制前端是否展示语音相关模块
 */
@property (nonatomic, assign) int haveModuleVoiceLive;

	/**
名称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<OnlineMallDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OnlineMallDTOModel*>*)list;

 +(OnlineMallDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OnlineMallDTOModel*) source target:(OnlineMallDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
