//
//  StoreProfileTableViewCell.h
//  Shopping
//
//  Created by yww on 2020/7/23.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailImageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StoreProfileTableViewCell : UITableViewCell//简介
@property (nonatomic, strong)StoreDetailSectionModel *sectionModel;
@end




@interface StorePromiseTableViewCell : UITableViewCell//承诺
@property (nonatomic, strong)StoreDetailSectionModel *sectionModel;
@end




@interface StoreLicenseTableViewCell : UITableViewCell//license
@property (nonatomic, strong)StoreDetailSectionModel *sectionModel;
@end

NS_ASSUME_NONNULL_END
