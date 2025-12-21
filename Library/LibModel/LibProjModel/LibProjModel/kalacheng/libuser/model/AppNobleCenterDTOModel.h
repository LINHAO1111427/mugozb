//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppGradeBasisInfoModel;
 @class AppGradePrivilegeDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
贵族中心
 */
@interface AppNobleCenterDTOModel : NSObject 


	/**
贵族名称集合
 */
@property (nonatomic, strong) NSMutableArray<AppGradeBasisInfoModel*>* gradeList;

	/**
到期天数
 */
@property (nonatomic, assign) int endDay;

	/**
我的等级
 */
@property (nonatomic, assign) int grade;

	/**
我图像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
我的贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
贵族对应的特权集合
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeDTOModel*>* noblePricelegeList;

 +(NSMutableArray<AppNobleCenterDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppNobleCenterDTOModel*>*)list;

 +(AppNobleCenterDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppNobleCenterDTOModel*) source target:(AppNobleCenterDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
