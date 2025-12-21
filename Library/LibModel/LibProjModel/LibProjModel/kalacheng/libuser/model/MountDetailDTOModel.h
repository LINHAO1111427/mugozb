//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppCarModel;
 @class AppLiangModel;
NS_ASSUME_NONNULL_BEGIN




/**
坐骑详情
 */
@interface MountDetailDTOModel : NSObject 


	/**
名称
 */
@property (nonatomic, copy) NSString * buyuname;

	/**
币种名称：钻石
 */
@property (nonatomic, copy) NSString * vcUnit;

	/**
null
 */
@property (strong, nonatomic) AppCarModel* appCar;

	/**
null
 */
@property (strong, nonatomic) AppLiangModel* liang;

 +(NSMutableArray<MountDetailDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MountDetailDTOModel*>*)list;

 +(MountDetailDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MountDetailDTOModel*) source target:(MountDetailDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
