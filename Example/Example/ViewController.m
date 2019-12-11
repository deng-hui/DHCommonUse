//
//  ViewController.m
//  DHUtils
//
//  Created by 王登辉 on 12/05/2019.
//  Copyright (c) 2019 王登辉. All rights reserved.
//

#import "ViewController.h"
#import "DHInjectionViewController.h"
#import "DHSocketViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = @[@"push",
                   @"present",
                   @"injection",
                   @"socket"
                    ];
    
    [self configureSubviews];
    
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}

#pragma mark - views
- (void)configureSubviews {
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *title = _dataArray[indexPath.item];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = _dataArray[indexPath.item];
    if ([title isEqualToString:@"push"]) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"present"]) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    } else if ([title isEqualToString:@"injection"]) {
        DHInjectionViewController *vc = [[DHInjectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"socket"]) {
        DHSocketViewController *vc = [[DHSocketViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
