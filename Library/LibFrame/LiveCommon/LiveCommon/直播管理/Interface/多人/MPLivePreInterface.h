//
//  MPLivePreInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MPLivePreInterface <NSObject>


- (void)showInView:(UIView *)superView openResult:(void(^)(BOOL success))resultBlock;


@end

NS_ASSUME_NONNULL_END
