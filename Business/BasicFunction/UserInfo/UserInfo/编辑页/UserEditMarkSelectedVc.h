//
//  UserEidteMarkSelectedVc.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UserInfoMarkSlectedCallBlock)(NSMutableArray *interstArr);
@interface UserEditMarkSelectedVc : UIViewController
@property(nonatomic,strong)NSMutableArray *myMarkArr;
@property (nonatomic, copy)UserInfoMarkSlectedCallBlock completeBlock;
@end

NS_ASSUME_NONNULL_END
 
