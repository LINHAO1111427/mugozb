//
//  GoodDetailNaviView.h
//  LibProjView
//
//  Created by klc_sl on 2021/8/2.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodDetailNaviView : UIView

@property (nonatomic, weak)UILabel *navTitleL;

@property (nonatomic, weak)UIButton *backBtn;

@property (nonatomic, weak)UIButton *rightBtn;

@property (nonatomic, assign)CGFloat bgAlpha;

@end

NS_ASSUME_NONNULL_END
