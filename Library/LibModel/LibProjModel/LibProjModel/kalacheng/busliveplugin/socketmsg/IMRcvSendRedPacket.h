//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "OneRedPacketVOModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
红包 socket
 */
@interface IMRcvSendRedPacket: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 发送红包后,刷新用户剩余红包数
 @param oneRedPacketVO null
 */
-(void) onSendRedPacket:(OneRedPacketVOModel* )oneRedPacketVO ;

@end

NS_ASSUME_NONNULL_END
