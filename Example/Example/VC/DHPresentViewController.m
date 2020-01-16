//
//  DHPresentViewController.m
//  Example
//
//  Created by wangdenghui on 2019/12/16.
//  Copyright © 2019 王登辉. All rights reserved.
//

#import "DHPresentViewController.h"





@interface DHPresentViewController ()<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) BOOL presentationStyleCustom;
@end

@implementation DHPresentViewController

- (instancetype)initWithPresentationStyleCustom:(BOOL)presentationStyleCustom {
    if (self = [super init]) {
        _presentationStyleCustom = presentationStyleCustom;
#ifdef DEBUG
        NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
        
        if (presentationStyleCustom) {
            self.modalPresentationStyle = UIModalPresentationCustom;
            self.transitioningDelegate = self;
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [btn setTitle:@"下一个" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClick:(id)sender {
//    DHPresentViewController *vc = [DHPresentViewController ]
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
#ifdef DEBUG
    NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
#endif
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView transitionWithView:self.view duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    } completion:nil];
}



#pragma mark -

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self;
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self;
//}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source API_AVAILABLE(ios(8.0)) {
//    return self;
//}


// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
//    [fromVc addChildViewController:toVc];
//    [self.view addSubview:<#childViewController#>.view];
//    [fromVc beginAppearanceTransition:YES animated:YES]
    [fromVc endAppearanceTransition];
    [transitionContext.containerView addSubview:toVc.view];
    [toVc beginAppearanceTransition:YES animated:YES];
//    [toVc didMoveToParentViewController:self];
    
    
    

//    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    [transitionContext completeTransition:YES];
}


@end
