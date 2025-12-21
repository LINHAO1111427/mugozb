//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ShopLiveAnnouncementDetailDTOModel.h"

#import "HttpNoneModel.h"

#import "ShopBusinessModel.h"

#import "AppMerchantAgreementDTOModel.h"

#import "ShopWithdrawDTOModel.h"

#import "ShopLiveInfoDTOModel.h"

typedef void (^CallBackShopBusiness_ShopLiveAnnouncementDetailDTOArr)(int code,NSString *strMsg,NSArray<ShopLiveAnnouncementDetailDTOModel*>* arr);
typedef void (^CallBackShopBusiness_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackShopBusiness_ShopBusiness)(int code,NSString *strMsg,ShopBusinessModel* model);
typedef void (^CallBackShopBusiness_AppMerchantAgreementDTO)(int code,NSString *strMsg,AppMerchantAgreementDTOModel* model);
typedef void (^CallBackShopBusiness_ShopWithdrawDTO)(int code,NSString *strMsg,ShopWithdrawDTOModel* model);
typedef void (^CallBackShopBusiness_ShopLiveInfoDTO)(int code,NSString *strMsg,ShopLiveInfoDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
商家接口API
 */
@interface HttpApiShopBusiness: NSObject



/**
 获取直播预告列表
 */
+(void) getLiveAnnouncementList:(CallBackShopBusiness_ShopLiveAnnouncementDetailDTOArr)callback;


/**
 删除直播预告
 @param liveAnnouncementId 预告id
 */
+(void) delLiveAnnouncement:(int64_t)liveAnnouncementId  callback:(CallBackShopBusiness_HttpNone)callback;


/**
 获取商家信息
 */
+(void) getOne:(CallBackShopBusiness_ShopBusiness)callback;


/**
 添加直播预告
 @param liveDate 直播日期
 @param posterStickers 海报贴纸
 @param shopCategory 购物分类
 @param startTime 开始时间
 @param title 标题
 */
+(void) saveLiveAnnouncement:(NSString *)liveDate posterStickers:(NSString *)posterStickers shopCategory:(NSString *)shopCategory startTime:(NSString *)startTime title:(NSString *)title  callback:(CallBackShopBusiness_HttpNone)callback;


/**
 是否申请入驻
 */
+(void) settleIn:(CallBackShopBusiness_AppMerchantAgreementDTO)callback;


/**
 获取商家提现配置信息
 */
+(void) getWithdrawInfo:(CallBackShopBusiness_ShopWithdrawDTO)callback;


/**
 商家入驻申请
 @param businessLicense 营业执照
 @param logo 商家LOGO
 @param mobile 联系电话
 @param name 商家名称
 @param present 商家简介
 @param presentPicture 商家简介图片地址
 */
+(void) applicationForResidence:(NSString *)businessLicense logo:(NSString *)logo mobile:(NSString *)mobile name:(NSString *)name present:(NSString *)present presentPicture:(NSString *)presentPicture  callback:(CallBackShopBusiness_AppMerchantAgreementDTO)callback;


/**
 修改商家信息
 @param businessId 商家id
 @param businessLicense 营业执照
 @param logo 商家LOGO
 @param mobile 联系电话
 @param name 商家名称
 @param present 商家简介
 @param presentPicture 商家简介图片地址
 */
+(void) updateBusiness:(int64_t)businessId businessLicense:(NSString *)businessLicense logo:(NSString *)logo mobile:(NSString *)mobile name:(NSString *)name present:(NSString *)present presentPicture:(NSString *)presentPicture  callback:(CallBackShopBusiness_AppMerchantAgreementDTO)callback;


/**
 获取商家直播信息
 @param anchorId 主播ID
 */
+(void) getLiveInfo:(int64_t)anchorId  callback:(CallBackShopBusiness_ShopLiveInfoDTO)callback;


/**
 获取商家直播预告列表
 @param userId 商家用户id
 */
+(void) getBusinessLiveAnnouncementList:(int64_t)userId  callback:(CallBackShopBusiness_ShopLiveAnnouncementDetailDTOArr)callback;

@end

NS_ASSUME_NONNULL_END
