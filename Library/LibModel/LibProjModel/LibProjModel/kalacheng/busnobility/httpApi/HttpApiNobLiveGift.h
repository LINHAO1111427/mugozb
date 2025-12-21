//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiGiftSenderModel.h"

#import "GiftSenderDataModel.h"
#import "ApiNobLiveGiftModel.h"

#import "HttpNoneModel.h"

#import "NobLiveGiftModel.h"

#import "GiftAmountSettingModel.h"

#import "GiftWallDtoModel.h"

typedef void (^CallBackNobLiveGift_ApiGiftSenderArr)(int code,NSString *strMsg,NSArray<ApiGiftSenderModel*>* arr);
typedef void (^CallBackNobLiveGift_ApiNobLiveGiftArr)(int code,NSString *strMsg,NSArray<ApiNobLiveGiftModel*>* arr);
typedef void (^CallBackNobLiveGift_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackNobLiveGift_NobLiveGiftArr)(int code,NSString *strMsg,NSArray<NobLiveGiftModel*>* arr);
typedef void (^CallBackNobLiveGift_GiftAmountSettingArr)(int code,NSString *strMsg,NSArray<GiftAmountSettingModel*>* arr);
typedef void (^CallBackNobLiveGift_GiftWallDtoArr)(int code,NSString *strMsg,NSArray<GiftWallDtoModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
贵族体系礼物接口API
 */
@interface HttpApiNobLiveGift: NSObject



/**
 发送积分礼物
 @param backid 背包id(没有传-1)
 @param giftId 礼物id
 @param giftSenderDataList giftSenderDataList
 @param number 礼物个数
 @param shortVideoId 短视频id(没有传-1)
 @param type 送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:家族礼物 9:短视频 10：个人主页送礼物 11：群聊礼物
 */
+(void) sendScoreGift:(int64_t)backid giftId:(int64_t)giftId giftSenderDataList:(NSMutableArray<GiftSenderDataModel*>* )giftSenderDataList number:(int)number shortVideoId:(int64_t)shortVideoId type:(int)type  callback:(CallBackNobLiveGift_ApiGiftSenderArr)callback;


/**
 获取礼物列表
 @param type 礼物类型 -1:查所有礼物 0:普通礼物 1:粉丝团(豪华礼物) 2:守护(专属礼物) 3:贵族礼物(特殊礼物) 4:背包礼物
 */
+(void) getGiftList:(int)type  callback:(CallBackNobLiveGift_ApiNobLiveGiftArr)callback;


/**
 求赏
 @param askType 求赏类型 1:直播间求赏(视频/语音/一对一) 2:聊天求赏(私信)
 @param nobGiftId 礼物id
 @param roomId 房间号(视频/语音/一对一才有,其他为0)
 @param toUserId 被求赏的用户id
 */
+(void) sendAskForAReward:(int)askType nobGiftId:(int64_t)nobGiftId roomId:(int64_t)roomId toUserId:(int64_t)toUserId  callback:(CallBackNobLiveGift_HttpNone)callback;


/**
 一键赠送所有背包礼物
 @param giftSenderDataList giftSenderDataList
 @param sendGiftType  送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:家族礼物 9:短视频 10：个人主页送礼物 11：群聊礼物 12:电视剧集
 @param shortVideoId 短视频id(没有传-1)
 */
+(void) senderGiftAll:(NSMutableArray<GiftSenderDataModel*>* )giftSenderDataList sendGiftType:(int)sendGiftType shortVideoId:(int64_t)shortVideoId  callback:(CallBackNobLiveGift_ApiGiftSenderArr)callback;


/**
 发送礼物HTTP
 @param backid 背包id(没有传-1)
 @param giftId 礼物id
 @param giftSenderDataList giftSenderDataList
 @param number 礼物个数
 @param shortVideoId 短视频id(没有传-1)
 @param type 送礼物类型 1:多人视频 2:语音直播 3:一对一 4:派对 5:电台 6:直播购物 7:私聊礼物 8:家族礼物 9:短视频 10：个人主页送礼物 11：群聊礼物 12:电视剧集
 */
+(void) giftSender:(int64_t)backid giftId:(int64_t)giftId giftSenderDataList:(NSMutableArray<GiftSenderDataModel*>* )giftSenderDataList number:(int)number shortVideoId:(int64_t)shortVideoId type:(int)type  callback:(CallBackNobLiveGift_ApiGiftSenderArr)callback;


/**
 我的的背包礼物
 */
+(void) getMyGiftList:(CallBackNobLiveGift_NobLiveGiftArr)callback;


/**
 获取发送礼物数量
 */
+(void) getGiftAmountSetting:(CallBackNobLiveGift_GiftAmountSettingArr)callback;


/**
 用户礼物墙
 @param userId 被查看的用户ID
 */
+(void) getUserGift:(int64_t)userId  callback:(CallBackNobLiveGift_GiftWallDtoArr)callback;

@end

NS_ASSUME_NONNULL_END
