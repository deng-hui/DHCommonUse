//
//  DHInjectionViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/10.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHInjectionViewController.h"

@interface DHInjectionViewController ()

@end


// 源码：  https://github.com/johnno1962/InjectionIII

@implementation DHInjectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    
    [self testInjection];
    [self testInjection222];
}

- (void)injected {
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
    self.view.backgroundColor = [UIColor blueColor];

}

- (void)testInjection {
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}

- (void)testInjection222 {
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}

@end
