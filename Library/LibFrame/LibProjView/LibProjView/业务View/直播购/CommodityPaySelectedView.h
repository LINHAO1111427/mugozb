//
//  CommodityPaySelectedView.h
//  LibProjView
//
//  Created by KLC on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum {
    PaySelectedTypeAll = 0,//购买+购物车
    PaySelectedTypeBuy,//购买
    PaySelectedTypeShopCart,//购物车
    PaySelectedTypeOnlySure//仅仅选择
}PaySelectedType;
@class ShopAttrComposeModel,ShopGoodsDetailDTOModel;
 
typedef void (^PaySelectedType_CallBack)(BOOL isBtnClick,ShopAttrComposeModel *attModel,int buy_num,int btn_index,UIImageView *imageV,CGFloat height);
@interface CommodityPaySelectedView : UIView
+ (void)showInSuperV:(UIView *)superV //父视图
     withDetailModel:(ShopGoodsDetailDTOModel *)detailModel //详情
       selectedModel:(ShopAttrComposeModel *)selectedModel //选择属性
          selctedNum:(int)num //购买数目
                type:(PaySelectedType)type //弹出类型
            callBack:(PaySelectedType_CallBack)callBack; //回调
@end

NS_ASSUME_NONNULL_END
