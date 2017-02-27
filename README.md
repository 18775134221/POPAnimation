
# 1.点赞动画（先缩小后放大）

###### 缩小并还原动画
eg:
```
    -(void) scaleSmallBase {
        POPBasicAnimation *scaleSmall = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleSmall.toValue = [NSValue valueWithCGPoint:CGPointMake(0.90, 0.90)];
        [self.buttion.layer pop_addAnimation:scaleSmall forKey:nil];
    }
```

###### 还原
eg:
```
    -(void) scaleBackBase {

        POPBasicAnimation *scaleBack = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleBack.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        [scaleBack setCompletionBlock:^(POPAnimation *animation, BOOL flag) {

        }];
        [self.buttion.layer pop_addAnimation:scaleBack forKey:nil];
    }

    -(void) scaleAnimationBase {

        POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        anSpring.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        anSpring.velocity = [NSValue valueWithCGPoint:CGPointMake(3.0, 3.0)];
        anSpring.springSpeed = 18.0;
        // 完成动画时会调用
        [anSpring setCompletionBlock:^(POPAnimation *animation, BOOL flag) {

        }];
        [self.buttion.layer pop_addAnimation:anSpring forKey:nil];

    }
```

# 2.按钮浮动效果
eg:
```

    -(void) setupAnimationDuration:(CAKeyframeAnimation*)keyAnimation btn:(UIButton *)btn time:(NSTimeInterval)timeInterval {

        keyAnimation.duration = timeInterval;
    }

    -(void)setBtnAnimation {

        __weak typeof(self) weakSelf = self;
        [self.arrayBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            __strong typeof(weakSelf) strongSelf = weakSelf;
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.fillMode = kCAFillModeForwards;
            pathAnimation.autoreverses=YES;

            pathAnimation.calculationMode = kCAAnimationPaced;
            pathAnimation.repeatCount = MAXFLOAT;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

            if (idx == strongSelf.arrayBtns.count - 1) {
                [strongSelf setupAnimationDuration:pathAnimation btn:obj time:4];
            }else {
                [strongSelf setupAnimationDuration:pathAnimation btn:obj time:5 + idx];
            }

            UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectInset(obj.frame, obj.frame.size.width/2-5, obj.frame.size.width/2-5)];
            pathAnimation.path=path.CGPath;
            [obj.layer addAnimation:pathAnimation forKey:@"pathAnimation"];

            CAKeyframeAnimation *scaleX=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
            scaleX.values   = @[@1.0, @1.1, @1.0];
            scaleX.keyTimes = @[@0.0, @0.5,@1.0];
            scaleX.repeatCount = MAXFLOAT;
            scaleX.autoreverses = YES;

            if (idx == strongSelf.arrayBtns.count - 2) {
                [strongSelf setupAnimationDuration:scaleX btn:obj time:7];
            }else if (idx == strongSelf.arrayBtns.count - 1) {
                [strongSelf setupAnimationDuration:scaleX btn:obj time:6];
            }else {
                [strongSelf setupAnimationDuration:scaleX btn:obj time:4 + idx];
            }
            [obj.layer addAnimation:scaleX forKey:@"scaleX"];


            CAKeyframeAnimation *scaleY=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
            scaleY.values   = @[@1.0, @1.1, @1.0];
            scaleY.keyTimes = @[@0.0, @0.5,@1.0];
            scaleY.repeatCount = MAXFLOAT;
            scaleY.autoreverses = YES;

            if (idx == strongSelf.arrayBtns.count - 2) {
                [strongSelf setupAnimationDuration:scaleY btn:obj time:4];
            }else if (idx == strongSelf.arrayBtns.count - 1) {
                [strongSelf setupAnimationDuration:scaleY btn:obj time:5];
            }else {
                [strongSelf setupAnimationDuration:scaleY btn:obj time:6 + idx];
            }
            [obj.layer addAnimation:scaleY forKey:@"scaleY"];

        }];
    }
```

# 3.返回顶部的弹性动画（常用于UITableView 和 UICollectionView）

    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPScrollViewContentOffset];
    animation.springSpeed = 10;
    animation.springBounciness = 8;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    [self.collectionView pop_addAnimation:animation forKey:nil];
    
# 4.POP 自定义动画 （可做计时器使用也可以做金融类余额的数字变动）

     POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {

            prop.writeBlock = ^(id obj, const CGFloat values[]) {
                UILabel *lable = (UILabel*)obj;
                lable.text = [NSString stringWithFormat:@"￥%.2f",values[0]];
            };
        }];

        POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
        anBasic.property = prop;    //自定义属性
        anBasic.fromValue = @(0);   //从0开始
        anBasic.toValue = @(10);  //180秒
        anBasic.duration = 10;    //持续.5
        anBasic.beginTime = CACurrentMediaTime() + .0f;    //延迟1秒开始
        [anBasic setCompletionBlock:^(POPAnimation *animation, BOOL flag) {

        }];
        [self.testLb pop_addAnimation:anBasic forKey:@"countdown"];
    
# 5.透明度动画（常用于做蒙版）
 
         POPSpringAnimation *showAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
        showAnimation.toValue = @1;
        showAnimation.springSpeed = 12;
        showAnimation.springBounciness = 4;
        [showAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        }];
        [self.maskBGView pop_addAnimation:showAnimation forKey:nil];

        // background的透明度
        POPSpringAnimation *showAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
        showAnimation.fromValue = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.f];
        showAnimation.toValue = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        showAnimation.springSpeed = 12;
        showAnimation.springBounciness = 4;
        [showAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        }];
        [self.maskBGView pop_addAnimation:showAnimation forKey:nil];
        
# 6.线条上下移动的动画（常见于扫码）
 ```
     /// 动画
        @objc private func startScanAnimation() {
            let animation = CABasicAnimation.init(keyPath: "transform.translation.y")
            animation.duration = 1.5
            animation.repeatCount = MAXFLOAT
            animation.fromValue = (-4)
            animation.toValue = (self.scanRect?.height)! + 4.0
            self.scanLineImageView?.layer.add(animation, forKey: "JKQRScanAnimationKey")
        }
   ```
        
# 7.cell展示的动画
  ```
  - (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.titlelabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
    } else {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness    = 20.f;
        [self.titlelabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}
```

# 8.UICollectionViewCell展示动画(在cell将要展示的代理方法上使用)
```
- (void) cellWillShowAnimation:(GFBWelcomeCell *) cell {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.duration           = 0.3f;
    scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL flag) {
        POPSpringAnimation *scaleAnimationF = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimationF.toValue             = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        scaleAnimationF.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimationF.springBounciness    = 20.f;
        [cell.bootImageView pop_addAnimation:scaleAnimationF forKey:@"scaleAnimation"];
        [cell.startBtn pop_addAnimation:scaleAnimationF forKey:@"scaleAnimation"];
    }];
    [cell.bootImageView pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [cell.startBtn pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
```

# 9.图片抖动
```
    //创建动画
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];//度数转弧度

    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    [self.iconImageView.layer addAnimation:keyAnimaion forKey:nil];
```
```
-(void)shakeAnimation:(UIView *)shakeView {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [shakeView.layer addAnimation:shakeAnimation forKey:nil];
}
```
    
    
