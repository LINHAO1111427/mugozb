//
//  OpenGuardView.h
//  TCDemo
//
//  Created by klc_tqd on 2019/11/14.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface OpenGuardView : UIView

@property (nonatomic, assign)int64_t userId;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userIcon;

///去充值
@property (nonatomic, copy)void(^toRechange)(void);

///购买成功
@property (nonatomic, copy)void(^buySuccess)(void);


- (void)showView;


@end

NS_ASSUME_NONNULL_END
