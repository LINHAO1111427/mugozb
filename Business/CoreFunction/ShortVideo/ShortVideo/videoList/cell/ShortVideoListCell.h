//
//  ShortVideoListCell.h
//  LibProjView
//
//  Created by KLC on 2020/6/24.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShortVideoListCell : UICollectionViewCell
@property (nonatomic, strong)ApiShortVideoDtoModel *model;
@end

NS_ASSUME_NONNULL_END
