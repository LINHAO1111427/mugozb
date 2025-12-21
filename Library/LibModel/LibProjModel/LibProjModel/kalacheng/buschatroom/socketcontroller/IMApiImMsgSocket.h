//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
NS_ASSUME_NONNULL_BEGIN



/**
仅用于通知用户上下线，无其它用户
 */
@interface IMApiImMsgSocket: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;
@end

NS_ASSUME_NONNULL_END
