//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvShopMsgSend.h"


/**
直播购相关的socket
 */
@implementation IMRcvShopMsgSend

-(NSString*) getMsgType
{
    return @"ShopMsgSend";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onUsersShopBanner"])
{
        [self onUsersShopBanner:[content getStr:@"shopLiveBanner"] ];
}else    if([subType isEqualToString:@"onBuyGoodsRoom"])
{
        [self onBuyGoodsRoom:[UserBuyDTOModel getFromDict:content[@"userBuyDTO"]] ];
}else    if([subType isEqualToString:@"onUsersLiveGoodsStatus"])
{
        [self onUsersLiveGoodsStatus:[ApiShopLiveGoodsModel getFromDict:content[@"apiShopLiveGoods"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 设置直播购横幅成功后发送
 @param shopLiveBanner null
 */
-(void) onUsersShopBanner:(NSString *)shopLiveBanner {  }
/**
 用户下单发送房间消息
 @param userBuyDTO null
 */
-(void) onBuyGoodsRoom:(UserBuyDTOModel* )userBuyDTO {  }
/**
 修改直播商品讲解中状态
 @param apiShopLiveGoods null
 */
-(void) onUsersLiveGoodsStatus:(ApiShopLiveGoodsModel* )apiShopLiveGoods {  }

@end


