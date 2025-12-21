//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
通讯录中的人数的数量
 */
@interface AppAddressBookNumberVOModel : NSObject 


	/**
关注用户数量
 */
@property (nonatomic, assign) int attentionNum;

	/**
粉丝用户数量
 */
@property (nonatomic, assign) int fansNum;

	/**
备注用户数量
 */
@property (nonatomic, assign) int remarkNum;

	/**
群组数量
 */
@property (nonatomic, assign) int groupNum;

	/**
密友用户数量
 */
@property (nonatomic, assign) int chummyNum;

 +(NSMutableArray<AppAddressBookNumberVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppAddressBookNumberVOModel*>*)list;

 +(AppAddressBookNumberVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppAddressBookNumberVOModel*) source target:(AppAddressBookNumberVOModel*)target;

@end

NS_ASSUME_NONNULL_END
