
# 1.点赞动画（先缩小后放大）

// 缩小并还原动画

-(void) scaleSmallBase {

    POPBasicAnimation *scaleSmall = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleSmall.toValue = [NSValue valueWithCGPoint:CGPointMake(0.90, 0.90)];
    [self.buttion.layer pop_addAnimation:scaleSmall forKey:nil];
}

// 还原

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

# 2.按钮浮动效果

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
