//
//  ViewController.m
//  testSB
//
//  Created by MAC on 2016/12/7.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "ViewController.h"
#import <POP/POP.h>
#import "PublicViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIButton *buttion;
@end

@implementation ViewController


- (UIView *)redView
{
    if (! _redView) {
        _redView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIButton *) buttion {
    if (! _buttion) {
        
        _buttion = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
        _buttion.backgroundColor = [UIColor blueColor];
        
    }
    return _buttion;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
 
}


- (void) setupUI
{
    [self.view addSubview:self.redView];
    [self.view addSubview:self.buttion];
    //self.settingLabel.text = @"已经实名验证";
    [self viewBingEvent];
}

- (UIView *)findKeyboard {
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    //逆序效率更高，因为键盘总在上方
    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView) {
            return keyboardView;
        }
    }
    return nil;
}

- (UIView *)findKeyboardInView:(UIView *)view {
    for (UIView *subView in [view subviews]) {
        if (strstr(object_getClassName(subView), "UIKeyboard")){
            return subView;
        }else {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView) {
                return tempView;
            }
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self test];
    //[self springTest];
    //[self decayTest];
    
    UIView *view = [self findKeyboard];
    NSLog(@"%@",view);
    
//    CGSize size = self.redView.frame.size;
//    CGFloat startHeight = size.height * 0.5;
//    CGFloat endHeight = size.height  * 0.5;
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, startHeight)];
//    [path addLineToPoint:CGPointMake(0, endHeight)];
//    [path addLineToPoint:CGPointMake(size.width, endHeight)];
//    [path addLineToPoint:CGPointMake(size.width, startHeight)];
//    [path addQuadCurveToPoint:CGPointMake(0, startHeight) controlPoint:CGPointMake(size.width/2, 0)];
//    [path addQuadCurveToPoint:CGPointMake(0, startHeight) controlPoint:CGPointMake(size.width/2, 0)];
//    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.strokeColor = [UIColor clearColor].CGColor;
//    layer.fillColor = [UIColor orangeColor].CGColor;
//    layer.path = path.CGPath;
//    
//    [self.redView.layer addSublayer:layer];
    
//    PublicViewController *vc = [PublicViewController new];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:navi animated:NO completion:nil];
}

- (void) viewBingEvent {
    
    [self.buttion addTarget:self action:@selector(scaleSmallBase) forControlEvents:UIControlEventTouchDown];
    [self.buttion addTarget:self action:@selector(scaleBackBase) forControlEvents:UIControlEventTouchUpInside];
    [self.buttion addTarget:self action:@selector(scaleAnimationBase) forControlEvents:UIControlEventTouchDragExit];
    

}

#pragma mark - 基本动画
/*
PropertyNamed ---> kPOPLayerPositionX 表示这个动画负责监听或者说动态变化的值
fromValue 表示这个动画监听值的起始值
toValue 表示这个动画监听值的结束值
beginTime 表示动画的起始时间，＋1.0f表示向后延时 1s
duration 表示动画的持续时间
timingFunction 表示动画的效果淡入淡出等
 */

// 平移
- (void) baseTest {
    POPBasicAnimation *anBase = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anBase.toValue = @(self.redView.center.x + 200);
    anBase.beginTime = CACurrentMediaTime() + 2;
    [self.redView pop_addAnimation:anBase forKey:nil];
}

#pragma mark - 常用于点赞效果
//// 缩小并还原动画
- (void) scaleSmallBase {
    POPBasicAnimation *scaleSmall = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleSmall.toValue = [NSValue valueWithCGPoint:CGPointMake(0.90, 0.90)];
    [self.buttion.layer pop_addAnimation:scaleSmall forKey:nil];
}

// 还原
- (void) scaleBackBase {
    POPBasicAnimation *scaleBack = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleBack.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    [scaleBack setCompletionBlock:^(POPAnimation *animation, BOOL flag) {
        
    }];
    [self.buttion.layer pop_addAnimation:scaleBack forKey:nil];
}

- (void) scaleAnimationBase {
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anSpring.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    anSpring.velocity = [NSValue valueWithCGPoint:CGPointMake(3.0, 3.0)];
    anSpring.springSpeed = 18.0;
    // 完成动画时会调用
    [anSpring setCompletionBlock:^(POPAnimation *animation, BOOL flag) {
        
    }];
    [self.buttion.layer pop_addAnimation:anSpring forKey:nil];

}

#pragma mark - 弹性动画

/*
 springBounciness:4.0    //[0-20] 弹力 越大则震动幅度越大
 springSpeed     :12.0   //[0-20] 速度 越大则动画结束越快
 dynamicsTension :0      //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
 dynamicsFriction:0      //摩擦 同上
 dynamicsMass    :0      //质量 同上
 velocity        ：      // 加速度值
 */

// 弹性动画
- (void) springTest {
    POPSpringAnimation *anspring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anspring.toValue = @300;
    anspring.springBounciness = 10;
    anspring.springSpeed = 12;
    [self.redView pop_addAnimation:anspring forKey:nil];
//    [self.redView pop_removeAllAnimations]; // 移除动画
}


#pragma mark - 衰减动画(阻尼动画，也可以叫做减速动画)
/*
deceleration:0.998  //衰减系数(越小则衰减得越快)
*/
- (void) decayTest {
    // 获取加速度值
    CGPoint velocity = CGPointMake(200, 200);
    // 初始化POPDecay衰减动画
    POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    [self.redView pop_addAnimation:decayAnimation forKey:nil];
}


@end
