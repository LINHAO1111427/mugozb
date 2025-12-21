//
//  LiveMoreCommonView.h
//  LibProjView
//
//  Created by admin on 2020/1/7.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveMoreCommonView : UIView

- (void)addItemName:(NSString *)name icon:(NSString *)icon msgType:(NSUInteger)msgType;

- (void)selectOne:(void(^)(NSUInteger msgType))select;

- (void)show;


@end

NS_ASSUME_NONNULL_END
