//
//  SampleHandler.m
//  DH_BroadcastExt
//
//  Created by wangdenghui on 2019/12/13.
//  Copyright © 2019 王登辉. All rights reserved.
//


#import "SampleHandler.h"
#import "DYLocalSocketClient.h"

@interface SampleHandler ()
@property(nonatomic, strong) DYLocalSocketClient *socketClient;
@end

@implementation SampleHandler


- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
    // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
    _socketClient = [[DYLocalSocketClient alloc] init];
    [_socketClient connect];
}

- (void)broadcastPaused {
    // User has requested to pause the broadcast. Samples will stop being delivered.
}

- (void)broadcastResumed {
    // User has requested to resume the broadcast. Samples delivery will resume.
}

- (void)broadcastFinished {
    // User has requested to finish the broadcast.
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
    
    [_socketClient sendData:@"wdh----------extension"];
    switch (sampleBufferType) {
        case RPSampleBufferTypeVideo:
            // Handle video sample buffer
            break;
        case RPSampleBufferTypeAudioApp:
            // Handle audio sample buffer for app audio
            break;
        case RPSampleBufferTypeAudioMic:
            // Handle audio sample buffer for mic audio
            break;
            
        default:
            break;
    }
}

@end
