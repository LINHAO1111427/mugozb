//
//  ShoppingAcceptAddressSelectedView.h
//  LibProjView
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class SASelctedModel;
typedef void (^AddressCallBack)(BOOL suceess, SASelctedModel *addressModel);
@interface ShoppingAddressSelectedView : UIView
+ (void)showInSuperV:(UIView *)superV height:(CGFloat)height selectedModel:(SASelctedModel *)model callBack:(AddressCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
