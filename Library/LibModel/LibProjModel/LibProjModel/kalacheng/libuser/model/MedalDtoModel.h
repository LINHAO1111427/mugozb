//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppMedalModel;
NS_ASSUME_NONNULL_BEGIN




/**
勋章页数据
 */
@interface MedalDtoModel : NSObject 


	/**
我没有的贵族勋章
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* noNobleMedals;

	/**
我没有的财富勋章
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* noWealthMedals;

	/**
我没有的用户勋章
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* noUserMedals;

	/**
我没有的守护勋章
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* noGuardMedals;

	/**
我的全部勋章
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* myAllMedals;

 +(NSMutableArray<MedalDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MedalDtoModel*>*)list;

 +(MedalDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MedalDtoModel*) source target:(MedalDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
