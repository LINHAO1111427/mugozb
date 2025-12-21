//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

@class IMSocketIns;
@class SingleStringModel;

typedef void (^CallBack_Live_SingleString)(int code,NSString *errMsg,SingleStringModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
直播间socket
 */
@interface IMApiLive: NSObject


@property (nonatomic, strong)IMSocketIns*  socket;
-(instancetype) init:(IMSocketIns*)socket;

/**
 leaveRoomAnchor
 @param roomId 房间id
 */
-(void) leaveRoomAnchor:(int64_t)roomId  callback:(CallBack_Live_SingleString)callback;


/**
 joinRoomAnchor
 @param roomId 房间id
 */
-(void) joinRoomAnchor:(int64_t)roomId  callback:(CallBack_Live_SingleString)callback;

@end

NS_ASSUME_NONNULL_END
