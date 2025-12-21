//
//  MusicSouceCell.h
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

@interface MusicSouceCell : UITableViewCell

kStrong(AppMusicDTOModel, model)

kBlock(addToListHandler,AppMusicDTOModel *model)


@end

NS_ASSUME_NONNULL_END
