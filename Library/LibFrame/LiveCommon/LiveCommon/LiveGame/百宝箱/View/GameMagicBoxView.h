//
//  GameMagicBoxView.h
//  klcProject
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameMagicBoxView : UIView

@property (nonatomic, assign, readonly)BOOL isLuckyBox; ///是否是黄金宝箱


- (instancetype)initWithIsLuckyBox:(BOOL)luckyBox;


- (void)shakeBox;

- (void)openBox:(void(^)(void))stopBlock;

- (void)closeBox;



@end

NS_ASSUME_NONNULL_END
