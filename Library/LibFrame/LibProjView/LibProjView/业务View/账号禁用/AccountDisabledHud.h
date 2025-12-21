//
//  AccountDisabledHud.h
//  LibProjView
//
//  Created by klc on 2020/8/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountDisabledHud : UIView



+ (void)shareDisable:(NSString *)str;




/**申诉回调*/
@property(nonatomic,copy)void (^appealBlock)(void);

@end

NS_ASSUME_NONNULL_END
