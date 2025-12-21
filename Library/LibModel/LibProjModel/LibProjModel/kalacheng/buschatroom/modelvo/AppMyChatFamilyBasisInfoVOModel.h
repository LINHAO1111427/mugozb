//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的信息显示的家族基本信息
 */
@interface AppMyChatFamilyBasisInfoVOModel : NSObject 


	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
家族名称
 */
@property (nonatomic, copy) NSString * familyName;

	/**
家族等级
 */
@property (nonatomic, assign) int familyGrade;

	/**
家族图标
 */
@property (nonatomic, copy) NSString * familyIcon;

	/**
家族等级图标
 */
@property (nonatomic, copy) NSString * familyGradeIcon;

 +(NSMutableArray<AppMyChatFamilyBasisInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMyChatFamilyBasisInfoVOModel*>*)list;

 +(AppMyChatFamilyBasisInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppMyChatFamilyBasisInfoVOModel*) source target:(AppMyChatFamilyBasisInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
