//
//  MineRelationItemCell.h
//  MessageInfo
//
//  Created by shirley on 2022/2/10.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppBookShowInfoVOModel.h>
NS_ASSUME_NONNULL_BEGIN

//type : 0 进入个人主页 1置顶 2备注 3跟随进房间
typedef void (^relationCellCallback)(int type,BOOL flag,AppBookShowInfoVOModel *model);
@interface MineRelationItemCell : UITableViewCell

//1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组
- (instancetype)initWithFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath type:(NSInteger)type;
@property(nonatomic,strong)AppBookShowInfoVOModel *model;
@property(nonatomic,copy)relationCellCallback callBack;
@end

NS_ASSUME_NONNULL_END
