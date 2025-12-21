//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiGuardEntityModel.h"

#import "GuardUserVOModel.h"

#import "HttpNoneModel.h"

#import "GuardVOModel.h"

#import "GuardListEntityModel.h"

typedef void (^CallBackGuard_ApiGuardEntity)(int code,NSString *strMsg,ApiGuardEntityModel* model);
typedef void (^CallBackGuard_GuardUserVO)(int code,NSString *strMsg,GuardUserVOModel* model);
typedef void (^CallBackGuard_GuardUserVOArr)(int code,NSString *strMsg,NSArray<GuardUserVOModel*>* arr);
typedef void (^CallBackGuard_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackGuard_GuardVOArr)(int code,NSString *strMsg,NSArray<GuardVOModel*>* arr);
typedef void (^CallBackGuard_GuardListEntity)(int code,NSString *strMsg,GuardListEntityModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
守护
 */
@interface HttpApiGuard: NSObject



/**
 守护类目列表
 @param anchorId 主播id
 */
+(void) getGuardList:(int64_t)anchorId  callback:(CallBackGuard_ApiGuardEntity)callback;


/**
 我守护的某个主播的守护信息
 @param userId 用户ID
 */
+(void) getMyGuardInfo:(int64_t)userId  callback:(CallBackGuard_GuardUserVO)callback;


/**
 守护的列表
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param queryType 0.全部，1.查询未过期的
 @param type 1.我守护的，2.守护我的
 @param userId 用户ID
 */
+(void) getMyGuardList:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType type:(int)type userId:(int64_t)userId  callback:(CallBackGuard_GuardUserVOArr)callback;


/**
 购买守护操作
 @param anchorId 主播id
 @param tid 守护规则id
 */
+(void) guardListBuy:(int64_t)anchorId tid:(int64_t)tid  callback:(CallBackGuard_HttpNone)callback;


/**
 null
 */
+(void) openGuard:(CallBackGuard_GuardVOArr)callback;


/**
 守护列表
 @param anchorId 主播id
 @param page 当前页
 @param pageSize 每页的条数
 */
+(void) guardList:(int64_t)anchorId page:(int)page pageSize:(int)pageSize  callback:(CallBackGuard_GuardListEntity)callback;

@end

NS_ASSUME_NONNULL_END
