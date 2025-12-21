//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
@class aTestModleModel;

@class SingleStringModel;

typedef void (^CallBack_ATestSocket_aTestModle)(int code,NSString *errMsg,aTestModleModel* model);
typedef void (^CallBack_ATestSocket_SingleString)(int code,NSString *errMsg,SingleStringModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
测试用的控制器
 */
@interface IMApiATestSocket: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;

/**
 getMsg2
 @param mdl null
 @param reqUid null
 */
-(void) getMsg2:(aTestModleModel* )mdl reqUid:(int64_t)reqUid  callback:(CallBack_ATestSocket_aTestModle)callback;


/**
 getMsg1
 @param assistanNo 麦位编号
 @param type 是否能直接上麦,1:能直接上麦,2,不能
 */
-(void) getMsg1:(int)assistanNo type:(int)type  callback:(CallBack_ATestSocket_aTestModle)callback;


/**
 getMsg3
 @param mdl null
 @param reqUid null
 */
-(void) getMsg3:(aTestModleModel* )mdl reqUid:(int64_t)reqUid  callback:(CallBack_ATestSocket_SingleString)callback;

@end

NS_ASSUME_NONNULL_END
