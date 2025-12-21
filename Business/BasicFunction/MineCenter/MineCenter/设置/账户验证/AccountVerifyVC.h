//
//  AccountVerifyVC.h
//  MineCenter
//
//  Created by klc on 2020/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountVerifyVC : UIViewController

/**Button标题*/
kCopyStr(btnTitle)

/**修改成功回调*/
@property(nonatomic,copy)void (^completeHandle)(void);

@end

NS_ASSUME_NONNULL_END
