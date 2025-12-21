//
//  ImSocketHander.h
//  TXImKit
//
//  Created by swh_y on 2022/5/26.
//

#ifndef IMReceiver_h
#define IMReceiver_h

@protocol IMReceiver <NSObject>

-(NSString*)getMsgType;

@optional

 
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;
   
 
@end
#endif /* ImSocketHander */
