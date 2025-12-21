//
//  LiveCloseInfoView.h
//  HomePage
//
//  Created by klc_sl on 2021/2/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppHomeHallDTOModel;

NS_ASSUME_NONNULL_BEGIN

@interface LiveCloseInfoView : UIView

@property (nonatomic, copy)void(^closeBtnClick)(void);

@property(nonatomic, strong)AppHomeHallDTOModel *dtoModel;


@end

NS_ASSUME_NONNULL_END
