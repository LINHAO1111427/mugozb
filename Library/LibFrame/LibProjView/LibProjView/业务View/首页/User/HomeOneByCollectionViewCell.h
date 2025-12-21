//
//  HomeOneByCollectionViewCell.h
//  LibProjView
//
//  Created by KLC on 2020/7/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppHomeHallDTOModel;
NS_ASSUME_NONNULL_BEGIN

///一对一

@interface HomeOneByCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)AppHomeHallDTOModel *model;
@end

NS_ASSUME_NONNULL_END
