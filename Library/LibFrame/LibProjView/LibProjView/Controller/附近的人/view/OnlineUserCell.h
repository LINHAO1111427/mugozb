//
//  OnlineUserCell.h
//  MessageCenter
//
//  Created by klc_tqd on 2020/6/2.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/HttpApiAnchorController.h>
NS_ASSUME_NONNULL_BEGIN

@protocol OnlineUserCellDelegate <NSObject>

-(void)clickHeaderImageModel:(ApiUsersLineModel *)model;
-(void)clickBtnTag:(NSInteger)tag andModel:(ApiUsersLineModel *)model;
 
@end


@interface OnlineUserCell : UITableViewCell

@property(nonatomic,weak)UIViewController *selfVc;
@property(nonatomic,strong)ApiUsersLineModel *model;
@property(nonatomic,weak)id<OnlineUserCellDelegate> delegate;

+(CGFloat)getOnlineUserCellHeight:(ApiUsersLineModel *)model;
@end

NS_ASSUME_NONNULL_END
