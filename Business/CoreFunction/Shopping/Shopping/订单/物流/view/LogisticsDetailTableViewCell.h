//
//  LogisticsDetailTableViewCell.h
//  Shopping
//
//  Created by yww on 2020/8/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LogisticsNodeDTOModel;
@interface LogisticsDetailTableViewCell : UITableViewCell
@property (nonatomic, assign)BOOL isFirstOne;
@property (nonatomic, assign)BOOL isLastOne;
@property (nonatomic, assign)int status;//0：暂无轨迹，1:快递收件，2：在途中,3：签收,4：问题件 5.疑难件 6.退件签收7：快递收件(揽件)
@property (nonatomic, strong)LogisticsNodeDTOModel *model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
