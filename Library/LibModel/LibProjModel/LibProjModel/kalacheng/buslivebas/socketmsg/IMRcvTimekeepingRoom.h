//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
NS_ASSUME_NONNULL_BEGIN



/**
计时房间消息
 */
@interface IMRcvTimekeepingRoom: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 余额不足提示
 @param times 60费用仅够1分钟；180费用仅够3分钟；返回的是180秒倒计时
 */
-(void) insufficientUserBalancePrompt:(int64_t)times ;


/**
 提醒充值
 @param msg null
 */
-(void) remindToRecharge:(NSString *)msg ;

@end

NS_ASSUME_NONNULL_END
