//
//  MyOrderV.h
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopOrderNumDTOModel.h>
 
NS_ASSUME_NONNULL_BEGIN
@protocol MyOrderVDelegate <NSObject>
@optional
- (void)MyOrderVFunctionBtnClick:(NSInteger)index;
@end
@interface MyOrderV : UIView
@property(nonatomic,weak)id<MyOrderVDelegate> delegate;
@property(nonatomic,copy)void(^MyOrderVBlock)(void);
@property (nonatomic, strong)ShopOrderNumDTOModel *model;

@end

NS_ASSUME_NONNULL_END
