//
//  InvitePictureCollectionViewCell.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/11.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AppInviteImgModel,InviteDtoModel;
@interface InvitePictureCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)InviteDtoModel *inviteModel;
@property (nonatomic, strong)AppInviteImgModel *model;
@end

NS_ASSUME_NONNULL_END
