//
//  UserInfoInputVc.h
//  LibProjController
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class AnchorAuthVOModel;
typedef void(^UserInfoInputCompletionBlock)(AnchorAuthVOModel *authModel);
@interface CAuthorityUserInfoInputVc : UIViewController
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,assign)int index;
@property(nonatomic,copy)NSString *placeholder;
@property (nonatomic, strong)AnchorAuthVOModel *authModel;
@property (nonatomic, copy)UserInfoInputCompletionBlock completeBlock;
@end

NS_ASSUME_NONNULL_END
