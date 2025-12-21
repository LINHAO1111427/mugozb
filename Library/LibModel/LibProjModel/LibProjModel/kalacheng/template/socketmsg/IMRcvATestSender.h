//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "aTestModleModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
用于测试的SOCKET
 */
@interface IMRcvATestSender: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 
 @param mdl null
 */
-(void) onGroupMsg:(aTestModleModel* )mdl ;


/**
 
 @param mdl null
 */
-(void) onRoomMsg:(aTestModleModel* )mdl ;


/**
 
 @param mdl null
 */
-(void) onAllMsg:(aTestModleModel* )mdl ;


/**
 
 @param mdl null
 */
-(void) onMyMsg:(aTestModleModel* )mdl ;

@end

NS_ASSUME_NONNULL_END
