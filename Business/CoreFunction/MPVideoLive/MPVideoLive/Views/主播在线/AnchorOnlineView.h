//
//  AnchorOnlineView.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface AnchorOnlineView : UIView

+ (void)showOnlineWishSelectConn:(void(^)(int64_t userID))selectBlock;

@end

NS_ASSUME_NONNULL_END
