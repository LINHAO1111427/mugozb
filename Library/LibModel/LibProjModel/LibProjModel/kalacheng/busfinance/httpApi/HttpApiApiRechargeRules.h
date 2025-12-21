//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "RechargeCenterVOModel.h"

typedef void (^CallBackApiRechargeRules_RechargeCenterVO)(int code,NSString *strMsg,RechargeCenterVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
充值中心api接口
 */
@interface HttpApiApiRechargeRules: NSObject



/**
 充值规则接口
 */
+(void) rulesList:(CallBackApiRechargeRules_RechargeCenterVO)callback;

@end

NS_ASSUME_NONNULL_END
