//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiUsersLiveWishModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
心愿单 socket
 */
@interface IMRcvLiveWishSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 心愿单设置成功推给房间
 @param awList null
 */
-(void) onSendWish:(NSMutableArray<ApiUsersLiveWishModel*>* )awList ;


/**
 心愿单设置成功推给用户
 @param awList null
 */
-(void) onSendWishUser:(NSMutableArray<ApiUsersLiveWishModel*>* )awList ;


/**
 主播收到心愿单礼物后推送给直播间
 @param list null
 */
-(void) onUserAddWishMsg:(NSMutableArray<ApiUsersLiveWishModel*>* )list ;


/**
 主播收到心愿单礼物后推送给直播间(用户)
 @param list null
 */
-(void) onUserAddWishMsgUser:(NSMutableArray<ApiUsersLiveWishModel*>* )list ;

@end

NS_ASSUME_NONNULL_END
