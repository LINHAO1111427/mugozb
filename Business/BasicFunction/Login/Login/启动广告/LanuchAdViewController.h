//
//  LanuchAdViewController.h
//  Login
//
//  Created by klc on 2020/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^launchAdCallBack)(BOOL isClick,NSString *openUrl);

@interface LanuchAdViewController : UIViewController

- (instancetype)initWithCallBack:(launchAdCallBack)callBack;

+ (void)showAdInfo:(NSString *)openUrl;

@end

NS_ASSUME_NONNULL_END
