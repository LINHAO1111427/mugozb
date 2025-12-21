//
//  UserInfoEditPickerObj.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiUserInfoModel;
typedef  void (^userInfoPickerCallBack)(BOOL isSure);

@interface UserInfoEditPickerObj : NSObject

- (void)showInfoPickerWithType:(int)type limit:(int)limit model:(ApiUserInfoModel *)userModel title:(NSString *)title callBack:(userInfoPickerCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
 
 
