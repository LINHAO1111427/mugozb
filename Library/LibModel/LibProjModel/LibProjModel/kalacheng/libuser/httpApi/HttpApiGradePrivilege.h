//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppUserPrivilegeDTOModel.h"

typedef void (^CallBackGradePrivilege_AppUserPrivilegeDTO)(int code,NSString *strMsg,AppUserPrivilegeDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
等级特权
 */
@interface HttpApiGradePrivilege: NSObject



/**
 查询用户/财富/主播 等级特权信息
 @param type type
 */
+(void) privlilegeInfo:(int)type  callback:(CallBackGradePrivilege_AppUserPrivilegeDTO)callback;

@end

NS_ASSUME_NONNULL_END
