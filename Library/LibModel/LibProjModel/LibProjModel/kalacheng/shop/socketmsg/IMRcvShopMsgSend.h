//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "UserBuyDTOModel.h"
#import "ApiShopLiveGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
直播购相关的socket
 */
@interface IMRcvShopMsgSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 设置直播购横幅成功后发送
 @param shopLiveBanner null
 */
-(void) onUsersShopBanner:(NSString *)shopLiveBanner ;


/**
 用户下单发送房间消息
 @param userBuyDTO null
 */
-(void) onBuyGoodsRoom:(UserBuyDTOModel* )userBuyDTO ;


/**
 修改直播商品讲解中状态
 @param apiShopLiveGoods null
 */
-(void) onUsersLiveGoodsStatus:(ApiShopLiveGoodsModel* )apiShopLiveGoods ;

@end

NS_ASSUME_NONNULL_END
