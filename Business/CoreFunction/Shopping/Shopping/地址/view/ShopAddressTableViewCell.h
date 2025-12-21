//
//  ShopAddressTableViewCell.h
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopAddressModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopAddressTableViewCell : UITableViewCell
@property (nonatomic, strong)ShopAddressModel *model;
@property (nonatomic, assign)BOOL isChoice;
@end

NS_ASSUME_NONNULL_END
