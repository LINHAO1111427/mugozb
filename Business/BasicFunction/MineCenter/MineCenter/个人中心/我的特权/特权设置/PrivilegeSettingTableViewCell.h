//
//  PrivilegeSettingTableViewCell.h
//  MineCenter
//
//  Created by ssssssss on 2020/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivilegeSettingModel : NSObject

@property (nonatomic, assign)int type;/// 0:关闭时提示文字  1打开时提示文字
@property (nonatomic, assign)int tag;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *tip;
@property (nonatomic, assign)BOOL openStatus;
@property (nonatomic, assign)int section;

@end


@interface PrivilegeSettingSectionModel : NSObject
@property (nonatomic, assign)int section;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSArray<PrivilegeSettingModel *> *titleArray;
@end


@class PrivilegeSettingTableViewCell;

@protocol PrivilegeSettingTableViewCellDelegate <NSObject>
@optional
- (void)PrivilegeSettingTableViewCell:(PrivilegeSettingTableViewCell *)cell swithBarValueChange:(BOOL)openStatus;

@end
@interface PrivilegeSettingTableViewCell : UITableViewCell

@property (nonatomic, assign)BOOL lastOne;

@property (nonatomic, strong)PrivilegeSettingModel *model;

@property (nonatomic, assign)id<PrivilegeSettingTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
