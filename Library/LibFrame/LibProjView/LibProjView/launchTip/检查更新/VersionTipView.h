//
//  VersionTipView.h
//  LibProjView
//
//  Created by klc on 2020/5/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^VersionTipCallback)(BOOL isCancel,NSString *openUrl);
@interface VersionTipView : UIView

+ (void)showVersionTip:(VersionTipCallback)callBack;

@end

NS_ASSUME_NONNULL_END
