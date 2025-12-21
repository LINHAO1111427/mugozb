//
//  MineHeaderView.h
//  MineCenter
//
//  Created by klc on 2020/5/21.
//

#import <UIKit/UIKit.h>

@class ApiUserInfoMyHeadModel;

NS_ASSUME_NONNULL_BEGIN
@class MineHeaderView;
@protocol MineHeaderViewDelegate <NSObject>
@optional

/// 进入个人主页
/// @param headerView header
/// @param model 模型
-(void)MineHeaderView:(MineHeaderView*)headerView userModel:(ApiUserInfoModel *)model;


/// 查看
/// @param headerView header
/// @param funcType 序列号
-(void)MineHeaderView:(MineHeaderView*)headerView funcType:(NSInteger )funcType userModel:(ApiUserInfoModel *)model;

@end

@interface MineHeaderView : UIView

@property(nonatomic,strong)ApiUserInfoMyHeadModel *userModel;

@property(nonatomic,copy)NSString *show_lookRedPoint;
@property (nonatomic, assign) int videoNum;
 
@property(nonatomic,weak)id<MineHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
