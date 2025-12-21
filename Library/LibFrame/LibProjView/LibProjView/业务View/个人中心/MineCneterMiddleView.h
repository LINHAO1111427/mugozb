//
//  MineCneterMiddleView.h
//  LibProjView
//
//  Created by klc_sl on 2021/2/20.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCneterMiddleView : UIView

@property (nonatomic, copy)void(^clickBtnBlock)(NSString *title, NSInteger indexType);//免打扰开关

- (void)createFunctionView:(NSArray *)funcArr;

@end

NS_ASSUME_NONNULL_END
