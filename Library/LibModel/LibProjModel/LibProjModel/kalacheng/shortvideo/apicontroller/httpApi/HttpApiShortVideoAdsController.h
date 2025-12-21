//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ShortVideoWatchAdsModel.h"

typedef void (^CallBackShortVideoAdsController_ShortVideoWatchAdsArr)(int code,NSString *strMsg,NSArray<ShortVideoWatchAdsModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
短视频广告API
 */
@interface HttpApiShortVideoAdsController: NSObject



/**
 获取短视频看点广告列表
 @param adsType 看点广告类型 1：图片广告 2:文字广告
 */
+(void) getShortVideoWatchAdsVO:(int)adsType  callback:(CallBackShortVideoAdsController_ShortVideoWatchAdsArr)callback;

@end

NS_ASSUME_NONNULL_END
