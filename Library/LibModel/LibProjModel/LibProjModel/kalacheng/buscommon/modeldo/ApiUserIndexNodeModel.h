//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserIndexNodeModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP用户中心接口动态功能实体
 */
@interface ApiUserIndexNodeModel : NSObject 


	/**
app类型h5/route
 */
@property (nonatomic, copy) NSString * app_type;

	/**
app转跳地址
 */
@property (nonatomic, copy) NSString * app_url;

	/**
图标
 */
@property (nonatomic, copy) NSString * icon;

	/**
功能名称
 */
@property (nonatomic, copy) NSString * name;

	/**
副标题
 */
@property (nonatomic, copy) NSString * remark;

	/**
id
 */
@property (nonatomic, assign) int id_field;

	/**
类型 1:横向1 2:横向2 3:竖向
 */
@property (nonatomic, assign) int type;

	/**
列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUserIndexNodeModel*>* userIndexNodeList;

 +(NSMutableArray<ApiUserIndexNodeModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserIndexNodeModel*>*)list;

 +(ApiUserIndexNodeModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserIndexNodeModel*) source target:(ApiUserIndexNodeModel*)target;

@end

NS_ASSUME_NONNULL_END
