//
//  RestAnchorInfoView.h
//  HomePage
//
//  Created by klc_sl on 2021/2/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestAnchorInfoView : UICollectionReusableView

@property(nonatomic, strong)AppHomeHallDTOModel *dtoModel;

@property (nonatomic, strong) UIView *noDataView; ///无数据提示显示

@end

NS_ASSUME_NONNULL_END
