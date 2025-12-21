//
//  EditGoodsPriceView.h
//  Shopping
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopAttrComposeModel;

@interface EditGoodsPriceView : UIView

@property (nonatomic, weak)UITextField *priceTextF;//价格
@property (nonatomic, weak)UITextField *discountPriceTextF;//优惠价格
@property (nonatomic, weak)UITextField *capacityTextF;//库存

@property (nonatomic, strong)ShopAttrComposeModel *attrModel;

@property (nonatomic, copy)void(^textFShouldBeginEditing)(EditGoodsPriceView *subView);

@end

NS_ASSUME_NONNULL_END
