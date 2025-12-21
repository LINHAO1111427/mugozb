//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 第三方登录
*/
@interface AppLogin_ChartLogin : NSObject 


 +(AppLogin_ChartLogin*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<AppLogin_ChartLogin*>*)getFromArr:(NSArray*)list;


	
	/**
app当前版本号
 */
@property (nonatomic, copy) NSString * appVersion;


	
	/**
当前版本code
 */
@property (nonatomic, copy) NSString * appVersionCode;


	
	/**
昵称
 */
@property (nonatomic, copy) NSString * nickname;


	
	/**
第三方标识
 */
@property (nonatomic, copy) NSString * openid;


	
	/**
手机厂商
 */
@property (nonatomic, copy) NSString * phoneFirm;


	
	/**
手机型号
 */
@property (nonatomic, copy) NSString * phoneModel;


	
	/**
手机唯一标识
 */
@property (nonatomic, copy) NSString * phoneUuid;


	
	/**
图片地址
 */
@property (nonatomic, copy) NSString * pic;


	
	/**
性别 0:保密 1:男 2:女
 */
@property (nonatomic, assign) int sex;


	
	/**
类型 1:QQ 2:微信 3：苹果登录 4：app唯一标识登录
 */
@property (nonatomic, assign) int type;

@end

NS_ASSUME_NONNULL_END
