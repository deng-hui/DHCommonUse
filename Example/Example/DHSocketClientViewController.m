//
//  DHSocketClientViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/10.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHSocketClientViewController.h"
#import "DYLocalSocketClient.h"

@interface DHSocketClientViewController ()

@property(nonatomic, strong) DYLocalSocketClient *client;

@property(nonatomic, strong) UIButton *startButton;
@property(nonatomic, strong) UIButton *sendButton;
@property(nonatomic, strong) UILabel *statsLabel;
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
    
    _client = [[DYLocalSocketClient alloc] init];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _startButton.frame = CGRectMake(0, 44, _startButton.frame.size.width,  _startButton.frame.size.width);
    _sendButton.frame = CGRectMake(100, 44, _sendButton.frame.size.width,  _sendButton.frame.size.width);
    _statsLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didClickStart:(id)sender {
    [_client connect];
}

- (void)didClickSend:(id)sender {
    [_client sendData:@"wdh---dadfasdfasdf"];
}

@end
