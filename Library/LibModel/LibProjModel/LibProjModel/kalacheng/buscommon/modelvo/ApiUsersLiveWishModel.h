//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiWishUserModel;
NS_ASSUME_NONNULL_BEGIN




/**
心愿单响应
 */
@interface ApiUsersLiveWishModel : NSObject 


	/**
礼物图片
 */
@property (nonatomic, copy) NSString * gifticon;

	/**
礼物积分价格
 */
@property (nonatomic, assign) double needScore;

	/**
心愿单礼物数
 */
@property (nonatomic, assign) int num;

	/**
礼物类型
 */
@property (nonatomic, assign) int type;

	/**
礼物名称
 */
@property (nonatomic, copy) NSString * giftname;

	/**
礼物头像
 */
@property (nonatomic, strong) NSMutableArray<ApiWishUserModel*>* wishUserList;

	/**
礼物id
 */
@property (nonatomic, assign) int giftid;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
是否选择 0:未选中 1:选中
 */
@property (nonatomic, assign) int isCheck;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
礼物金币价格
 */
@property (nonatomic, assign) double needcoin;

	/**
心愿单id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
收到的礼物数
 */
@property (nonatomic, assign) int sendNum;

	/**
状态 0:进行中 1:已结束
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<ApiUsersLiveWishModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersLiveWishModel*>*)list;

 +(ApiUsersLiveWishModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUsersLiveWishModel*) source target:(ApiUsersLiveWishModel*)target;

@end

NS_ASSUME_NONNULL_END
