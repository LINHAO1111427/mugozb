//
//  MessageUserJoinView.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageUserJoinView : UIView

@property (nonatomic, weak)UILabel *titleL;

@property (nonatomic, weak)UIButton *nameBtn;

@property (nonatomic, weak)UIButton *welcomeBtn;

- (void)welconUserNameJoinRoom:(NSString *)name;



@end

NS_ASSUME_NONNULL_END
