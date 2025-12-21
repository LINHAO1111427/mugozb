//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "LianAiUserSignVOModel.h"

typedef void (^CallBackLianAiScoreController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackLianAiScoreController_LianAiUserSignVOArr)(int code,NSString *strMsg,NSArray<LianAiUserSignVOModel*>* arr);
typedef void (^CallBackLianAiScoreController_LianAiUserSignVO)(int code,NSString *strMsg,LianAiUserSignVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
恋爱积分
 */
@interface HttpApiLianAiScoreController: NSObject



/**
 获取用户恋爱积分
 */
+(void) getLianAiUserScore:(CallBackLianAiScoreController_HttpNone)callback;


/**
 获取恋爱签到列表
 */
+(void) getLianAiSignList:(CallBackLianAiScoreController_LianAiUserSignVOArr)callback;


/**
 恋爱签到
 */
+(void) lianAiSign:(CallBackLianAiScoreController_LianAiUserSignVO)callback;


/**
 恋爱用户是否可以签到
 */
+(void) lianAiSignVerify:(CallBackLianAiScoreController_HttpNone)callback;


/**
 录链爱交友APP任务
 */
+(void) finishFriendLoginTask:(CallBackLianAiScoreController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
