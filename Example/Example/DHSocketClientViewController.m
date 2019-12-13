//
//  DHSocketClientViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/10.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHSocketClientViewController.h"
#import "DYLocalSocketClient.h"
#import "GCDAsyncSocketCommunicationManager.h"
#import "GACConnectConfig.h"
#define kDefaultChannel @"dkf"

@interface DHSocketClientViewController ()

@property(nonatomic, strong) DYLocalSocketClient *client;

@property(nonatomic, strong) UIButton *startButton;
@property(nonatomic, strong) UIButton *sendButton;
@property(nonatomic, strong) UILabel *statsLabel;

@property (nonatomic, strong) GACConnectConfig *connectConfig;

@end

@implementation DHSocketClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_startButton setTitle:@"client开始" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(didClickStart:) forControlEvents:UIControlEventTouchUpInside];
    [_startButton sizeToFit];
    _startButton.frame = CGRectMake(0, 44, _startButton.frame.size.width,  _startButton.frame.size.width);
    [self.view addSubview:_startButton];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sendButton setTitle:@"client发送" forState:UIControlStateNormal];
    [_sendButton sizeToFit];
    _sendButton.frame = CGRectMake(100, 44, _sendButton.frame.size.width,  _sendButton.frame.size.width);
    [_sendButton addTarget:self action:@selector(didClickSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendButton];
    
    _statsLabel = [[UILabel alloc] init];
    _statsLabel.text = @"...";
    _statsLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_statsLabel];
    
//    _client = [[DYLocalSocketClient alloc] init];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _startButton.frame = CGRectMake(0, 44, _startButton.frame.size.width,  _startButton.frame.size.width);
    _sendButton.frame = CGRectMake(100, 44, _sendButton.frame.size.width,  _sendButton.frame.size.width);
    _statsLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didClickStart:(id)sender {
//    [_client connect];
    
    
    // 2.自定义配置连接环境
        [[GCDAsyncSocketCommunicationManager sharedInstance] createSocketWithConfig:self.connectConfig];
}

- (void)didClickSend:(id)sender {
//    [_client sendData:@"wdh---dadfasdfasdf"];
        [[GCDAsyncSocketCommunicationManager sharedInstance] socketWriteDataWithRequestType:GACRequestType_Beat requestBody:@{@"ddddd":@"客户端-wdh-----send"} completion:^(NSError * _Nullable error, id  _Nullable data) {
    #ifdef DEBUG
            NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
    #endif
        }];
    
}


- (GACConnectConfig *)connectConfig {
    if (!_connectConfig) {
        _connectConfig = [[GACConnectConfig alloc] init];
        _connectConfig.channels = kDefaultChannel;
        _connectConfig.currentChannel = kDefaultChannel;
        _connectConfig.host = @"127.0.0.1";
        _connectConfig.port = 7070;
        _connectConfig.socketVersion = 5;
    }
    _connectConfig.token = @"f14c4e6f6c89335ca5909031d1a6efa9";
    
    return _connectConfig;
}

@end
