//
//  guardPayBtn.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/GuardVOModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface guardPayBtn : UIButton
@property (nonatomic, strong)GuardVOModel *model;
@property (nonatomic, assign)BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
