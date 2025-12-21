//
//  LiveGoodsManagerView.h
//  LibProjView
//
//  Created by klc_sl on 2020/7/10.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    GoodsManagerTypeLive = 0,//直播
    GoodsManagerTypeShortVideo
} GoodsManagerType;
@class ShopGoodsDTOModel;
typedef void (^LiveGoodsManagerCallback)(BOOL close,ShopGoodsDTOModel *model);
@interface LiveGoodsManagerView : UIView
+ (void)showGoodsListType:(GoodsManagerType)managerType selectedModel:(ShopGoodsDTOModel*)selectedModel CallBack:(LiveGoodsManagerCallback)callBack;

@end

NS_ASSUME_NONNULL_END
