//
//  LiveTradePreviewTableViewCell.h
//  Shopping
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopLiveAnnouncementDetailDTOModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveTradePreviewTableViewCell : UITableViewCell

- (void)showPreviewModel:(ShopLiveAnnouncementDetailDTOModel *)dtoModel isEmpty:(BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
