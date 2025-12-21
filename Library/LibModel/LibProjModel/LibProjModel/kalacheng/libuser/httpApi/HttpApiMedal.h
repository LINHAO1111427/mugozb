//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "MedalDtoModel.h"

typedef void (^CallBackMedal_MedalDto)(int code,NSString *strMsg,MedalDtoModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
勋章支持接口
 */
@interface HttpApiMedal: NSObject



/**
 获取用户已经持有的和未持有的所有勋章
 @param userId 被查看的用户ID
 */
+(void) getMyAllMedal:(int64_t)userId  callback:(CallBackMedal_MedalDto)callback;

@end

NS_ASSUME_NONNULL_END
