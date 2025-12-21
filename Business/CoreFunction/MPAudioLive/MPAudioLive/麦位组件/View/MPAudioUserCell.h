//
//  MPAudioUserCell.h
//  OTMLive
//
//  Created by klc_sl on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUsersVoiceAssistanModel;

@interface MPAudioUserCell : UICollectionViewCell

@property (nonatomic, weak)UILabel *userNameL;

@property (nonatomic, weak)UILabel *hotL;

@property (nonatomic, strong)ApiUsersVoiceAssistanModel *seatModel;


- (void)speakIng:(NSUInteger)volume uid:(int64_t)uid;


@end

NS_ASSUME_NONNULL_END
