//
//  SASelectedTableViewCell.h
//  LibProjView
//
//  Created by klc on 2020/7/21.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SASelectedTableViewCell : UITableViewCell
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)BOOL isChoice;
@end

NS_ASSUME_NONNULL_END
