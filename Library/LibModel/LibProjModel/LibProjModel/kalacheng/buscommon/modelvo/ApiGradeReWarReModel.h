//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiGradeReListModel;
NS_ASSUME_NONNULL_BEGIN




/**
等级升级大礼包
 */
@interface ApiGradeReWarReModel : NSObject 


	/**
下一等级总经验值
 */
@property (nonatomic, assign) int nextLevelTotalEmpirical;

	/**
下一等级还需经验值
 */
@property (nonatomic, assign) int nextLevelEmpirical;

	/**
下一个礼包需要的等级(-1:当前用户等级之后再也没有礼包)
 */
@property (nonatomic, assign) int nextGiftPackLevel;

	/**
礼包列表
 */
@property (nonatomic, strong) NSMutableArray<ApiGradeReListModel*>* apiGradeReList;

	/**
下一等级
 */
@property (nonatomic, assign) int nextLevel;

	/**
当前等级
 */
@property (nonatomic, assign) int currLevel;

 +(NSMutableArray<ApiGradeReWarReModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGradeReWarReModel*>*)list;

 +(ApiGradeReWarReModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiGradeReWarReModel*) source target:(ApiGradeReWarReModel*)target;

@end

NS_ASSUME_NONNULL_END
