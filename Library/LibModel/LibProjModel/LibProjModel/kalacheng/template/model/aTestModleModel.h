//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
测试Model
 */
@interface aTestModleModel : NSObject 


	/**
null
 */
@property (nonatomic, copy) NSString * name;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
null
 */
@property (nonatomic, assign) int64_t pid;

	/**
null
 */
@property (nonatomic, assign) int age;

	/**
null
 */
@property (nonatomic, assign) int sex;

	/**
null
 */
@property (nonatomic, copy) NSString * homeAddress;

	/**
null
 */
@property (nonatomic, copy) NSString * nickname;

	/**
null
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
null
 */
@property (nonatomic, assign) double moneyxx;

	/**
null
 */
@property (nonatomic, assign) double moneysdfsdf;

 +(NSMutableArray<aTestModleModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<aTestModleModel*>*)list;

 +(aTestModleModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(aTestModleModel*) source target:(aTestModleModel*)target;

@end

NS_ASSUME_NONNULL_END
