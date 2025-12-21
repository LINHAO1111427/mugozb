//
//  StoreDetailInfoTable.h
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerView.h>
#import <LibProjModel/ShopBusinessModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailInfoTable : UITableView<JXPagerViewListViewDelegate>
@property (nonatomic, strong)ShopBusinessModel *business;//商家信息
@end

NS_ASSUME_NONNULL_END
