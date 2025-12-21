//
//  OfficialMessageDetailVC.h
//  Message
//
//  Created by klc_sl on 2020/8/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AppOfficialNewsDTOModel;

@interface OfficialMessageDetailVC : UIViewController

@property (nonatomic, strong)AppOfficialNewsDTOModel *dtoModel;

@end

NS_ASSUME_NONNULL_END
