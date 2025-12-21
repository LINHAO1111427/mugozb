//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"
#import <LibTools/NSDictionary+Json.h>
#import "IMApiOOOCall.h"
#import <TXImKit/TXImKit.h>




@implementation IMApiOOOCall

-(instancetype) init:(IMSocketIns*)socket
{
    self=[super init];
    if(self)
{
    self.socket=socket;
    }
    return self;
}

@end


