//
//  myCommodityTableViewCell.h
//  Shopping
//
//  Created by klc on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopGoodsDTOModel.h>

NS_ASSUME_NONNULL_BEGIN
@class myCommodityTableViewCell;
@protocol myCommodityTableViewCellDelegate <NSObject>
@optional
- (void)myCommodityTableViewCellOneSetViewClick:(myCommodityTableViewCell *)cell itemClick:(NSInteger)index;

@end
@interface myCommodityTableViewCell : UITableViewCell
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)ShopGoodsDTOModel *model;
@property (nonatomic, assign)id<myCommodityTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
