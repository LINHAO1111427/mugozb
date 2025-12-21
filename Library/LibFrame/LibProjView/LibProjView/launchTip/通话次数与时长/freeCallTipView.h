//
//  FreeCallTipView.h
//  LibProjView
//
//  Created by klc on 2020/6/3.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^FreeCallTipCallback)(BOOL close);
@interface FreeCallTipView : UIView

+ (void)showFreeCallTipWithComplete:(FreeCallTipCallback)callBack;

@end

NS_ASSUME_NONNULL_END
