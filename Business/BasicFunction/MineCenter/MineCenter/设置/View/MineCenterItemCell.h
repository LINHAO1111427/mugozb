//
//  MineCenterItemCell.h
//  TCDemo
//
//  Created by admin on 2019/10/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const MineCenterItemCellIdentifier;
@interface MineCenterItemCell : UITableViewCell

///功能名称
@property (nonatomic, weak)UILabel *funcionLab;
@property (nonatomic, weak)UILabel *detailLab;

//退出按钮
@property (nonatomic, weak)UILabel *logoutLab;

@property (nonatomic, assign)BOOL isLogout;  //是否为退出登录按钮

@end

NS_ASSUME_NONNULL_END
