//
//  GameResultView.h
//  klcProject
//
//  Created by klc_sl on 2020/7/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameResultView : UIView

+ (void)showResult:(NSArray *)items userLastCoin:(double)coin closeBlock:(void(^)(void))closeBlock;

@end

NS_ASSUME_NONNULL_END
