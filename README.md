# POPAnimation

1.点赞动画（先缩小后放大）
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
