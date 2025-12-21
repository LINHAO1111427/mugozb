//
//  ShopOderListCell.h
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopCarModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShopOrderListCell : UITableViewCell
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)ShopCarModel *model;
@end

NS_ASSUME_NONNULL_END
