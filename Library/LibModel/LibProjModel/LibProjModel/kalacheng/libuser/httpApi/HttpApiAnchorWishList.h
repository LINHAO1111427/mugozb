//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ApiUsersLiveWishModel.h"

#import "HttpNoneModel.h"

typedef void (^CallBackAnchorWishList_ApiUsersLiveWishArr)(int code,NSString *strMsg,NSArray<ApiUsersLiveWishModel*>* arr);
typedef void (^CallBackAnchorWishList_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
主播心愿单接口API
 */
@interface HttpApiAnchorWishList: NSObject



/**
 获取主播心愿单
 @param anchorID 主播id
 */
+(void) getWishList:(int64_t)anchorID  callback:(CallBackAnchorWishList_ApiUsersLiveWishArr)callback;


/**
 设置主播心愿单,参数对象传入giftid和num即可
 @param gifts gifts
 @param roomId 房间号(群聊和直播间时传入否则传-1)
 @param touid 对方用户id(私聊时传入否则传-1)
 */
+(void) setWish:(NSMutableArray<ApiUsersLiveWishModel*>* )gifts roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackAnchorWishList_HttpNone)callback;


/**
 获取心愿单礼物列表
 @param anchorID 主播id
 */
+(void) getWishGiftList:(int64_t)anchorID  callback:(CallBackAnchorWishList_ApiUsersLiveWishArr)callback;

@end

NS_ASSUME_NONNULL_END
