//
//  GameAllSocket.m
//  LiveGame
//
//  Created by klc_sl on 2020/11/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "GameAllSocket.h"
#import "GameGlobalNotice.h"
#import <LibProjBase/ProjBaseData.h>

@interface GameAllSocket ()


@property (nonatomic, copy)GameGlobalNotice *gameNotice;
 
@end

@implementation GameAllSocket

/**
 中奖之后发送socket信息
 @param gameUserWinAwardsDTO null
 */
- (void)onUserWinAPrize:(GameUserWinAwardsDTOModel *)gameUserWinAwardsDTO {
    [self.gameNotice playGlobalPrize:gameUserWinAwardsDTO];
}


- (GameGlobalNotice *)gameNotice{
    if (!_gameNotice) {
        _gameNotice = [[GameGlobalNotice alloc] initWithSuperView:[ProjBaseData share].allBannerBgView];
    }
    return _gameNotice;
}


@end
