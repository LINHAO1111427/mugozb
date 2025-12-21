//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * APP修改个人信息
*/
@interface UserController_userUpdate : NSObject 


 +(UserController_userUpdate*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<UserController_userUpdate*>*)getFromArr:(NSArray*)list;


	
	/**
生日
 */
@property (nonatomic, copy) NSString * birthday;


	
	/**
星座
 */
@property (nonatomic, copy) NSString * constellation;


	
	/**
身高
 */
@property (nonatomic, assign) int height;


	
	/**
封面
 */
@property (nonatomic, copy) NSString * liveThumb;


	
	/**
三围
 */
@property (nonatomic, copy) NSString * sanwei;


	
	/**
性别0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;


	
	/**
签名
 */
@property (nonatomic, copy) NSString * signature;


	
	/**
用户名
 */
@property (nonatomic, copy) NSString * username;


	
	/**
职业
 */
@property (nonatomic, copy) NSString * vocation;


	
	/**
微信号
 */
@property (nonatomic, copy) NSString * wechat;


	
	/**
体重
 */
@property (nonatomic, assign) int weight;

@end

NS_ASSUME_NONNULL_END
