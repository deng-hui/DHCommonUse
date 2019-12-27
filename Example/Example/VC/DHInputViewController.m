//
//  DHInputViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/26.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHInputViewController.h"

@interface DHInputViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *nameTextField;

@property(nonatomic, strong) UITextField *passwordTextField;

@end

@implementation DHInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 300, 100)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    [view addSubview:self.nameTextField];
    
    
//    [self.view addSubview:[[UITextField alloc] initWithFrame:CGRectMake(30, 251, 200, 1)]];
//    [self.view addSubview:[[UITextField alloc] initWithFrame:CGRectMake(30, 254, 200, 1)]];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(30, 300, 300, 100)];
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    
    [view2 addSubview:self.passwordTextField];
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
    [self printView:self.view];
#endif
}
#ifdef DEBUG

#define ramdomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f])

- (void)printView:(UIView *)view {
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = ramdomColor.CGColor;
    
    for (UIView *subView in view.subviews) {
        [self printView:subView];
    }
}
#endif


- (void)textFieldClick:(UITextField *)textField {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [textField becomeFirstResponder];
    /// 2. 在切换时先resign 然后become
    if (textField == self.nameTextField) {
        textField.secureTextEntry = NO;
    } else {
        // 3. 在真正用到的地方置为yes
        textField.secureTextEntry = YES;
    }
    // 4. 如果还有其他的加密框，在切换时需要将secureTextEntry置为NO
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, 200, 44)];
//        _nameTextField.secureTextEntry = NO;
//        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
//        _nameTextField.textContentType = UITextContentTypeNickname;
        _nameTextField.delegate = self;
        [_nameTextField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _nameTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, 200, 44)];
        // 1. 初始化的时候不要设置secureTextEntry
//        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.delegate = self;
        [_passwordTextField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _passwordTextField;
}

@end
