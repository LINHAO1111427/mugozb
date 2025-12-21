//
//  OneLiveInfoBottomInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OneLiveInfoBottomInterface <NSObject>

+ (instancetype)registerView;

- (void)reloadFunctionBtn;
 
@end

NS_ASSUME_NONNULL_END
