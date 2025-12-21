//
//  CAuthorityMarkCollectionCell.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/4.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
 
NS_ASSUME_NONNULL_BEGIN
@class TabInfoDtoModel;
@interface CAuthorityMarkCollectionCell : UICollectionViewCell
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)TabInfoDtoModel *model;
@property(nonatomic,assign)BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
