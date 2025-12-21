//
//  MyCenterAuthenStateView.h
//  MineCenter
//
//  Created by klc on 2020/7/30.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    authenStateUnAuthen,//未认证
    authenStateProcessing,//处理中
    authenStateFail,//认证失败
} AuthenState;

NS_ASSUME_NONNULL_BEGIN

@interface MyCenterAuthenStateView : UIView

@property(nonatomic,assign,readonly)AuthenState state;

- (instancetype)initWithFrame:(CGRect)frame authState:(AuthenState)state authenHandler:(void (^)(AuthenState state))authenHandler;

@end

NS_ASSUME_NONNULL_END
