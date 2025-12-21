//
//  CAuthorityMarkSlectedVc.h
//  MineCenter
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CAuthorityMarkSlectedCallBlock)(NSMutableArray *interstArr);
@interface CAuthorityMarkSlectedVc : UIViewController
@property(nonatomic,strong)NSMutableArray *myMarkArr;
@property (nonatomic, copy)CAuthorityMarkSlectedCallBlock completeBlock;
@end

NS_ASSUME_NONNULL_END
