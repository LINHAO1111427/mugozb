//
//  SVTrySeeAlertVC.h
//  ShortVideo
//
//  Created by klc_sl on 2021/5/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApiShortVideoDtoModel;
NS_ASSUME_NONNULL_BEGIN

@interface SVTrySeeAlertVC : UIViewController

@property (nonatomic, strong)ApiShortVideoDtoModel *dtoModel;

@property (nonatomic, copy)void(^isPlayBlock)(BOOL isPlay);


@end

NS_ASSUME_NONNULL_END
