//
//  CAuthorityInfoPickerObj.h
//  MineCenter
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AnchorAuthVOModel;

typedef  void (^AuthorityInfoPickerCallBack)(BOOL isSure,AnchorAuthVOModel *authModel);

@interface CAuthorityInfoPickerObj : NSObject

- (void)showInfoPickerWithType:(int)type limit:(int)limit model:(AnchorAuthVOModel *)authModel title:(NSString *)title callBack:(AuthorityInfoPickerCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
