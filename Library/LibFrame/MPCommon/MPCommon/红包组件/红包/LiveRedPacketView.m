//
//  LiveRedPacketView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveRedPacketView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>

@implementation LiveRedPacketView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView *redPacket = [[UIImageView alloc] initWithFrame:self.bounds];
    redPacket.contentMode = UIViewContentModeScaleAspectFit;
    redPacket.image = [UIImage imageNamed:@"redpacket_mini_envelope"];
    [self addSubview:redPacket];
    _redPacket = redPacket;
    
    UIButton *packetNumBtn = [[UIButton alloc] init];
    packetNumBtn.backgroundColor = [UIColor whiteColor];
    packetNumBtn.userInteractionEnabled = NO;
    packetNumBtn.layer.masksToBounds = YES;
    packetNumBtn.layer.cornerRadius = 7.5;
    packetNumBtn.layer.borderWidth = 1.0;
    packetNumBtn.layer.borderColor = kRGBA_COLOR(@"#A20000", 1.0).CGColor;
    [packetNumBtn setTitleColor:kRGBA_COLOR(@"#A20000", 1.0) forState:UIControlStateNormal];
    packetNumBtn.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    packetNumBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
    packetNumBtn.hidden = YES;
    [redPacket addSubview:packetNumBtn];
    _packetNumBtn = packetNumBtn;
    [packetNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(13);
        make.right.equalTo(self).mas_offset(-13);
        make.height.mas_equalTo(15);
    }];
}

- (void)showPacketInfo:(int)packetNum{
    [self.packetNumBtn setTitle:[NSString stringWithFormat:@"%d",packetNum] forState:UIControlStateNormal];
    self.packetNumBtn.hidden = ((packetNum == 1)?YES:NO);
}


@end
