//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class GuardUserVOModel;
 @class AppGradePrivilegeModel;
 @class ApiGradeReWarReModel;
 @class TaskDtoModel;
 @class AppMedalModel;
NS_ASSUME_NONNULL_BEGIN




/**
我的-等级特权,可能是H5页面用
 */
@interface MyMemberVOModel : NSObject 


	/**
我守护的List
 */
@property (nonatomic, strong) NSMutableArray<GuardUserVOModel*>* myGuardList;

	/**
魅力等级特权
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeModel*>* charmGradePrivilegeList;

	/**
守护我的List
 */
@property (nonatomic, strong) NSMutableArray<GuardUserVOModel*>* guardMyList;

	/**
用户等级特权
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeModel*>* userGradePrivilegeList;

	/**
财富等级特权
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeModel*>* wealthGradePrivilegeList;

	/**
主播等级特权
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeModel*>* anchorGradePrivilegeList;

	/**
下一级升级大礼包
 */
@property (strong, nonatomic) ApiGradeReWarReModel* levelPackList;

	/**
用户任务列表
 */
@property (nonatomic, strong) NSMutableArray<TaskDtoModel*>* userTaskList;

	/**
所有勋章-勋章墙（3个）
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* threeMedal;

	/**
贵族等级特权
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeModel*>* nobleGradePrivilegeList;

 +(NSMutableArray<MyMemberVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyMemberVOModel*>*)list;

 +(MyMemberVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MyMemberVOModel*) source target:(MyMemberVOModel*)target;

@end

NS_ASSUME_NONNULL_END
