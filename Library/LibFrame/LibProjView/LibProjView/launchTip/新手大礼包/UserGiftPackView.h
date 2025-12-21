//
//  UserGiftPackView.h
//  LibProjView
//
//  Created by klc on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^GiftPackCallback)(BOOL isSucess);
@interface UserGiftPackView : UIView

+ (void)showGiftPackCallBack:(GiftPackCallback)callBack;

@end

NS_ASSUME_NONNULL_END
