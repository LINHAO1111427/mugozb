//
//  FansGroupListView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FansInfoDtoModel;
typedef void (^FansGroupListCallback)(BOOL showUserInfo,int64_t userId);
@interface FansGroupListView : UIView

+ (void)showList:(FansInfoDtoModel *)dtoModel userId:(int64_t)userId callBack:(FansGroupListCallback)callBack;

@end

NS_ASSUME_NONNULL_END
