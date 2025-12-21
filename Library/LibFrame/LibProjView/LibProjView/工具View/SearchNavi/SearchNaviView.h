//
//  SearchNaviView.h
//  TCDemo
//
//  Created by admin on 2019/10/25.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchNaviView : UIView

@property (nonatomic, copy)NSString *searchPlaceholder;

@property (nonatomic, copy)void(^searchText)(NSString * __nullable text);


@end

NS_ASSUME_NONNULL_END
