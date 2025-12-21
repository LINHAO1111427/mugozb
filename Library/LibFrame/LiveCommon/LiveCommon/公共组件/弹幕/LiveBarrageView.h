//
//  LiveBarrageView.h
//  TCDemo
//
//  Created by CH on 2019/11/21.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApiSimpleMsgRoomModel;
NS_ASSUME_NONNULL_BEGIN

@interface LiveBarrageView : UIView

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)addMsg:(ApiSimpleMsgRoomModel *)model;


@end

NS_ASSUME_NONNULL_END
