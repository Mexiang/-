//
//  ViewController.m
//  EnlargeTest
//
//  Created by Dry on 2017/7/29.
//  Copyright © 2017年 Dry. All rights reserved.
//

#import "ViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kAnimationKey @"AnimationKey"

static const NSUInteger kStartButtonTag = 1000;
static const NSUInteger kStopButtonTag = 1001;

@interface ViewController ()

@property (nonatomic, strong) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpUI];
}
- (void)setUpUI {
    _testView = [[UIView alloc] initWithFrame:CGRectMake(kWidth * 0.5 - 50, kHeight * 0.5 - 50, 100, 100)];
    _testView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.1];
    _testView.layer.cornerRadius = _testView.frame.size.width * 0.5;
    [self.view addSubview:self.testView];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(kWidth*0.5-50, kHeight-200, 100, 60);
    [startButton setTitle:@"开启动画" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [startButton setTag:kStartButtonTag];
    [startButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *stopSender = [UIButton buttonWithType:UIButtonTypeCustom];
    stopSender.frame = CGRectMake(kWidth*0.5-50, kHeight-100, 100, 60);
    [stopSender setTitle:@"停止动画" forState:UIControlStateNormal];
    [stopSender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [stopSender setTag:kStopButtonTag];
    [stopSender addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopSender];
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case kStartButtonTag:
            //开启动画
            [self showAnitation];

            break;
        case kStopButtonTag:
            //移除动画
            [self removeAnimation];
            
            break;
    }
}

//添加动画方法
- (void)showAnitation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 1.5;//动画时间
    animation.repeatCount = HUGE;//动画无线循环
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.testView.layer addAnimation:animation forKey:kAnimationKey];
}

//移除动画方法
- (void)removeAnimation {
    //此处duration最好与动画时长保持一致
    [UIView animateWithDuration:1.5 animations:^{
        
        [self.testView.layer removeAnimationForKey:kAnimationKey];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
