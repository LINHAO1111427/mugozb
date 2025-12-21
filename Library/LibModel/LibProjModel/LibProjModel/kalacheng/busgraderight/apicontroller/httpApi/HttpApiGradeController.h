//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiGradeReWarReModel.h"

typedef void (^CallBackGradeController_ApiGradeReWarRe)(int code,NSString *strMsg,ApiGradeReWarReModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
等级控制器
 */
@interface HttpApiGradeController: NSObject



/**
 用户/主播等级信息
 @param type 类型 1:用户 2:主播
 */
+(void) userLevelInfo:(int)type  callback:(CallBackGradeController_ApiGradeReWarRe)callback;

@end

NS_ASSUME_NONNULL_END
