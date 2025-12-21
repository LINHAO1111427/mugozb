//
//  DynamicTopicItemCell.h
//  klcProject
//
//  Created by ssssssss on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiUserVideoModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface DynamicTopicItemCell : UICollectionViewCell
@property (nonatomic, strong)ApiUserVideoModel *model;
@end

NS_ASSUME_NONNULL_END
