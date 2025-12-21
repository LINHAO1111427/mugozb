//
//  MedalTableViewCell.h
//  UserInfo
//
//  Created by ssssssss on 2020/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MedalTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *medalsArr;//勋章列表 
- (instancetype)initWithIndexPath:(NSIndexPath *)indexpath;
@end

NS_ASSUME_NONNULL_END
