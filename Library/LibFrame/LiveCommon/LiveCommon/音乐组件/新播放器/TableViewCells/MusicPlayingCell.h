//
//  MusicPlayingCell.h
//  LiveCommon
//
//  Created by klc on 2020/8/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiAppMusic.h>
#import <LibProjBase/HttpClient.h>


NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayingCell : UITableViewCell


kAssign(NSUInteger, sort)

kAssign(BOOL, isPlaying)//是否播放，暂停也属于在播放

kAssign(BOOL, isPause)

kStrong(AppUserMusicDTOModel, model)
kBlock(removeFromListHandler,NSUInteger index)



@end

NS_ASSUME_NONNULL_END
