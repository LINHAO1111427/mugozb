//
//  userGuradDetailTableCell.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GuardUserVOModel;
 
@interface userGuradDetailTableCell : UITableViewCell
@property (nonatomic, strong)GuardUserVOModel *guardModel;
 
@end

NS_ASSUME_NONNULL_END
