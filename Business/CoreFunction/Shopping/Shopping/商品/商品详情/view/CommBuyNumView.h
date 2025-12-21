//
//  CommBuyNumView.h
//  Shopping
//
//  Created by tctd on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^callBack)(int num);
@interface CommBuyNumView : UIView
@property (nonatomic, copy)callBack callBack;
@end

NS_ASSUME_NONNULL_END
