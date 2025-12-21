//
//  FamilyRoomItemCell.h
//  OTMLive
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveRoomInfoVOModel;
NS_ASSUME_NONNULL_BEGIN

@interface FamilyRoomItemCell : UICollectionViewCell

@property(nonatomic, weak)UIImageView *userThumb;  ///主播封面

@property (nonatomic, weak)UILabel *roomNumL;  ///房间人数

@property (nonatomic, weak)UILabel *userNameL;  ///主播名称
 
@property (nonatomic, weak)UIImageView *selectImgV;  ///房间标示

@property (nonatomic, weak)UIButton *roomTypeBtn;  ///房间分类


@property (nonatomic, strong)LiveRoomInfoVOModel *voModel;

@end

NS_ASSUME_NONNULL_END
