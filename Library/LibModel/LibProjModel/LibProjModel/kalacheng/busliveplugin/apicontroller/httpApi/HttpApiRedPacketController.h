//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "RedPacketReceiveRecordVOModel.h"

#import "RedPacketVOModel.h"

#import "HttpNoneModel.h"

#import "RedPacketController_sendRedPacket.h"
typedef void (^CallBackRedPacketController_RedPacketReceiveRecordVOArr)(int code,NSString *strMsg,NSArray<RedPacketReceiveRecordVOModel*>* arr);
typedef void (^CallBackRedPacketController_RedPacketVO)(int code,NSString *strMsg,RedPacketVOModel* model);
typedef void (^CallBackRedPacketController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
app红包
 */
@interface HttpApiRedPacketController: NSObject



/**
 单个红包领取记录
 @param redPacketId 红包id
 */
+(void) redPacketRecord:(int64_t)redPacketId  callback:(CallBackRedPacketController_RedPacketReceiveRecordVOArr)callback;


/**
 领红包
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 @param redPacketId 红包id
 */
+(void) openRedPacket:(int)liveType redPacketId:(int64_t)redPacketId  callback:(CallBackRedPacketController_RedPacketVO)callback;




/**
 发送红包
 @param anchorId 在房间红包时必填,其他填-1
 @param currencyType 货币类型 1：金币 2：积分
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 @param otherUserId 收红包的用户id(指定红包时必传,其他传空字符串)
 @param redPacketAmount 红包数量
 @param redPacketRange 红包发送的范围 1:房间红包(直播间内/一对一/聊天家族) 2:指定红包
 @param redPacketType 红包类型 1:普通红包
 @param roomId 房间号
 @param showId 直播标识
 @param totalValue 红包总价值
 */
+(void) sendRedPacket:(RedPacketController_sendRedPacket*)_mdl callback:(CallBackRedPacketController_HttpNone)callback;
/**
 发送红包
 @param anchorId 在房间红包时必填,其他填-1
 @param currencyType 货币类型 1：金币 2：积分
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 @param otherUserId 收红包的用户id(指定红包时必传,其他传空字符串)
 @param redPacketAmount 红包数量
 @param redPacketRange 红包发送的范围 1:房间红包(直播间内/一对一/聊天家族) 2:指定红包
 @param redPacketType 红包类型 1:普通红包
 @param roomId 房间号
 @param showId 直播标识
 @param totalValue 红包总价值
 */
+(void) sendRedPacket:(int64_t)anchorId currencyType:(int)currencyType liveType:(int)liveType otherUserId:(NSString *)otherUserId redPacketAmount:(int)redPacketAmount redPacketRange:(int)redPacketRange redPacketType:(int)redPacketType roomId:(int64_t)roomId showId:(NSString *)showId totalValue:(double)totalValue  callback:(CallBackRedPacketController_HttpNone)callback;


/**
 获取我是否领过某个红包
 @param redPacketId 红包id
 */
+(void) getMyRedPacketReceiveVO:(int64_t)redPacketId  callback:(CallBackRedPacketController_RedPacketVO)callback;

@end

NS_ASSUME_NONNULL_END
