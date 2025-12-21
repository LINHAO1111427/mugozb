//
//  PolicyTipsView.h
//  LibProjView
//
//  Created by klc on 2020/4/30.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface PolicyTipsView : UIView

+ (void)showInVC:(UIViewController *)vc closeBlock:(void(^)(void))closeBlock;



@end

NS_ASSUME_NONNULL_END
