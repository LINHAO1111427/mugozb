//
//  StoreLiveInfoView.h
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopLiveDetailDTOModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreLiveInfoView : UIView

@property (nonatomic, assign)int64_t liveRoomId;
@property (nonatomic, strong)ShopLiveDetailDTOModel *liveDetailDTO;//直播信息

@end

NS_ASSUME_NONNULL_END
