//
//  AttentOrFansTableViewCell.h
//  Fans
//
//  Created by ssssssss on 2020/1/8.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppBookShowInfoVOModel.h>
NS_ASSUME_NONNULL_BEGIN

//type : 0 进入个人主页 1置顶 2备注 3跟随进房间
typedef void (^relationCellCallback)(int type,BOOL flag,AppBookShowInfoVOModel *model);
@interface AttentOrFansTableViewCell : UITableViewCell
//type : 0关注 1粉丝 2密友 3备注 4群组
- (instancetype)initWithFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath type:(NSInteger)type;
@property(nonatomic,strong)AppBookShowInfoVOModel *model;
@property(nonatomic,copy)relationCellCallback callBack;
@end

NS_ASSUME_NONNULL_END
