//
//  DHSocketViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/10.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHSocketViewController.h"
#import "DHSocketClientViewController.h"
#import "DYLocalSocket.h"

@interface DHSocketViewController ()
@property(nonatomic, strong) DHSocketClientViewController *clientVc;
@property(nonatomic, strong) UIButton *startButton;
@property(nonatomic, strong) UIButton *sendButton;
@property(nonatomic, strong) UILabel *statsLabel;

@property(nonatomic, strong) DYLocalSocket *socket;
@end

@implementation DHSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _clientVc = [[DHSocketClientViewController alloc] init];
    [self addChildViewController:_clientVc];
    [self.view addSubview:_clientVc.view];
    _clientVc.view.frame = CGRectMake(0, self.view.frame.size.height / 2.0, self.view.frame.size.width, self.view.frame.size.height);
    [_clientVc didMoveToParentViewController:self];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_startButton setTitle:@"service开始" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(didClickStart:) forControlEvents:UIControlEventTouchUpInside];
    [_startButton sizeToFit];
    _startButton.frame = CGRectMake(0, 100, _startButton.frame.size.width,  _startButton.frame.size.width);
    [self.view addSubview:_startButton];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sendButton setTitle:@"service发送" forState:UIControlStateNormal];
    [_sendButton sizeToFit];
    _sendButton.frame = CGRectMake(100, 100, _sendButton.frame.size.width,  _sendButton.frame.size.width);
    [_sendButton addTarget:self action:@selector(didClickSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendButton];
    
    _statsLabel = [[UILabel alloc] init];
    _statsLabel.text = @"...";
    _statsLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_statsLabel];
    
    _socket = [[DYLocalSocket alloc] init];
}

- (void)didClickStart:(id)sender {
    [_socket start];
}

- (void)didClickSend:(id)sender {
    [_socket sendMessage];
}

@end
