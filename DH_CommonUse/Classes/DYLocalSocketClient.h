//
//  DYLocalSocketClient.h
//  DH_CommonUse
//
//  Created by wangdenghui on 2019/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYLocalSocketClient : NSObject

- (void)connect;

- (void)sendData:(NSString *)data;

@end

NS_ASSUME_NONNULL_END
