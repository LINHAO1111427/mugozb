//
//  HostOrderTableViewCell.h
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopSubOrderModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface HostOrderTableViewCell : UITableViewCell
@property (nonatomic, assign)BOOL lastOne;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)ShopSubOrderModel * model;
@end

NS_ASSUME_NONNULL_END
