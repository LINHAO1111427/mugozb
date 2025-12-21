//
//  FocusCollectionViewCell.h
//  ShortVideo
//
//  Created by KLC on 2020/6/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/AppHomeHallDTOModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface SVSortCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)ApiShortVideoDtoModel *model;
@property (nonatomic, strong)AppHomeHallDTOModel *homeModel;
 
@end

NS_ASSUME_NONNULL_END
