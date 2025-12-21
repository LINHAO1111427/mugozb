//
//  FocusVideoCollectionViewCell.h
//  ShortVideo
//
//  Created by KLC on 2020/6/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppHotSortModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface FocusVideoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) AppHotSortModel *model;
@end

NS_ASSUME_NONNULL_END
