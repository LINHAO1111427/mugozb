//
//  RelationUserListVC.h
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RelationUserListVC : UIViewController

@property (nonatomic, copy)NSString *navTitle;

///1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组
@property (nonatomic, assign)int showType;


@end

NS_ASSUME_NONNULL_END
