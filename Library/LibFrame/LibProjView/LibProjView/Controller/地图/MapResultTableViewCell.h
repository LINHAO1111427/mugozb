//
//  MapResultTableViewCell.h
//  LibProjView
//
//  Created by klc on 2020/5/12.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapResultTableViewCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *infoAddress;
@property (nonatomic, strong) NSIndexPath *indexPath;
- (instancetype)initWithIndexpath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
