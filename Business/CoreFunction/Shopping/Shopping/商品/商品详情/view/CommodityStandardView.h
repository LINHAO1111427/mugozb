//
//  CommodityStandardView.h
//  Shopping
//
//  Created by klc on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopAttrComposeModel.h>

NS_ASSUME_NONNULL_BEGIN
@class CommodityStandardView;
@protocol CommodityStandardViewDelegate <NSObject>
@optional
- (void)CommodityStandardViewClick:(CommodityStandardView *)standardView;
@end
@interface CommodityStandardView : UIView
@property (nonatomic, strong) ShopAttrComposeModel *model;
@property (nonatomic, strong) ShopAttrComposeModel *selectedAttriModel;
@property (nonatomic, assign)int num;
@property (nonatomic, weak)id<CommodityStandardViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
