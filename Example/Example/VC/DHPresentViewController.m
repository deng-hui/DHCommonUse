//
//  DHPresentViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/16.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHPresentViewController.h"

@interface DHPresentViewController ()

@end

@implementation DHPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView transitionWithView:self.view duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    } completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
