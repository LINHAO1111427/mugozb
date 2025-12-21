//
//  AttentOrFansListVC.h
//  Fans
//
//  Created by ssssssss on 2020/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

 
@interface AttentOrFansListVC : UIViewController
///FansContentType:  0/1/2
@property (nonatomic, copy)NSNumber *contentType;//0关注 1粉丝 2谁看过我
@property (nonatomic, copy)NSNumber *userId;
@property (nonatomic, copy)NSString *navTitle;

@end

NS_ASSUME_NONNULL_END
