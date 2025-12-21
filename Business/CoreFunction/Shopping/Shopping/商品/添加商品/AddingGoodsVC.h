//
//  AddingGoodsVC.h
//  Shopping
//
//  Created by kalacheng on 2020/6/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface AddingGoodsVC : UIViewController

@property (nonatomic, strong)NSNumber *isModify;
@property (nonatomic, strong)ShopGoodsDTOModel *model;

@end

NS_ASSUME_NONNULL_END
