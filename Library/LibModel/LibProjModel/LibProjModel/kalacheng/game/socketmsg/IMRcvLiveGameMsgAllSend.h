//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "GameUserWinAwardsDTOModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
发送游戏消息给所有人
 */
@interface IMRcvLiveGameMsgAllSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 中奖之后发送socket信息
 @param gameUserWinAwardsDTO null
 */
-(void) onUserWinAPrize:(GameUserWinAwardsDTOModel* )gameUserWinAwardsDTO ;

@end

NS_ASSUME_NONNULL_END
