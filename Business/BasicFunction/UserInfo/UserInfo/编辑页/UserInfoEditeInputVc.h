//
//  UserInfoEidteInputVc.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiUserInfoModel;
typedef void(^UserInfoInputCompletionBlock)(BOOL sucess);
@interface UserInfoEditeInputVc : UIViewController
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,assign)int index;
@property(nonatomic,copy)NSString *placeholder;
@property (nonatomic, strong)ApiUserInfoModel *userModel;
@property (nonatomic, copy)UserInfoInputCompletionBlock completeBlock;
@end

NS_ASSUME_NONNULL_END
 
 
