//
//  MineDynamicTableViewCell.h
//  MineCenter
//
//  Created by ssssssss on 2019/12/23.
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    TimeAxisType0 = 0,
    TimeAxisType1,
    TimeAxisType2,
    TimeAxisType3,
    TimeAxisType4,
    TimeAxisType5,
    TimeAxisType6
} TimeAxisType;
@class MineTimeAxisTableViewCell;
@protocol MineTimeAxisTableViewCellDelegate <NSObject>
@optional
- (void)MineTimeAxisTableViewCellAvaterBtnClick:(AppTrendsRecordModel *)model;
- (void)MineTimeAxisTableViewCellActionBtnClick:(AppTrendsRecordModel *)model index:(NSInteger)index;
@end
@interface MineTimeAxisTableViewCell : UITableViewCell
@property (nonatomic, assign)CGFloat cell_height;
@property (nonatomic, assign)BOOL isShowYear;
@property(nonatomic,assign)TimeAxisType type;
@property(nonatomic,strong)NSIndexPath *indexpath;
@property (nonatomic, strong)ApiUserInfoModel *userModel;
@property (nonatomic, strong)AppTrendsRecordModel *trendsRecordModel;
@property(nonatomic,weak)id<MineTimeAxisTableViewCellDelegate> delegate;
- (instancetype)initWithIndexpath:(NSIndexPath *)indexPath timeAxisType:(TimeAxisType)type;
@end

NS_ASSUME_NONNULL_END
