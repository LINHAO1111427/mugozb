//
//  SelectGiftNumObj.h
//  MPVideoLive
//
//  Created by admin on 2019/8/6.
//  Copyright © 2019 cat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectGiftNumObj : NSObject

@property (nonatomic, copy)void(^selectBlock)(NSString *count);
@property (nonatomic, copy)void(^cancelBlock)(void);

@property (nonatomic, assign)NSInteger selectIndex;

- (void)loadGiftNumberList;

- (void)show;

@end

NS_ASSUME_NONNULL_END
