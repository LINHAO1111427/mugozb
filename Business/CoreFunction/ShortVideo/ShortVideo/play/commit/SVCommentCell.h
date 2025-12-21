//
//  SVCommentCell.h
//  ShortVideo
//
//  Created by ssssssss on 2020/6/22.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiUsersVideoCommentsModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface SVCommentCell : UITableViewCell
@property(nonatomic,strong)ApiUsersVideoCommentsModel *model;
@property (nonatomic, copy)void (^userInfo)(int64_t touid);
@end

NS_ASSUME_NONNULL_END
