//
//  UserListItemCell.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/SWHTapImageView.h>
@class ApiUserBlackInfoVOModel;

FOUNDATION_EXPORT NSString *const UserListItemCellIdentifier;
@interface UserListItemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconV;

@property (weak, nonatomic) IBOutlet UIImageView *hostlevel;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet SWHTapImageView *sexL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexLwidthConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *levelL;

@property (weak, nonatomic) IBOutlet UILabel *signatureL;

///默认隐藏
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


@property (nonatomic, copy)ApiUserBlackInfoVOModel *model;


@property (nonatomic, copy)void(^clickCancelBtn)(UserListItemCell *cell);


@end
