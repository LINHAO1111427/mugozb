//
//  CommodityAttributeSeletedView.h
//  Shopping
//
//  Created by tctd on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopAttrComposeModel.h>
NS_ASSUME_NONNULL_BEGIN
 
typedef void (^AttributeSeletedCallback)(BOOL isBtnClick,ShopAttrComposeModel *model,int num,int index,UIImageView *imageV,CGFloat height);
@interface CommodityAttributeSeletedView : UIView
//type:  0 普通 1购物车 2 购买
+ (void)showInSuperV:(UIView *)superV with:(ShopGoodsDetailDTOModel *)detailModel selectedModel:(ShopAttrComposeModel *)selectedModel type:(int)type callBack:(AttributeSeletedCallback)callBack;
@end

NS_ASSUME_NONNULL_END
