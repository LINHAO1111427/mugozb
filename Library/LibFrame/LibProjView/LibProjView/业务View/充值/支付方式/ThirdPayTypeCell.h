//
//  ThirdPayTypeCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/28.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class CfgPayWayDTOModel;

NS_ASSUME_NONNULL_BEGIN

@interface ThirdPayTypeCell : UITableViewCell

@property (nonatomic, weak)UIView *lineV;

@property (nonatomic, weak)UILabel *titleL;

@property (nonatomic, strong)CfgPayWayDTOModel *payModel;

@end

NS_ASSUME_NONNULL_END
