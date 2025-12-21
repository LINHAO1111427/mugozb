//
//  PageInfo.h
//  TCDemo
//
//  Created by admin on 2019/10/22.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageInfo : UIView

@property (nonatomic, assign) int pageSize;

@property (nonatomic, assign) int pageIndex;

@property (nonatomic, assign) int outTotalPage;

@property (nonatomic, assign) int outTotalCount;


- (void)setInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
