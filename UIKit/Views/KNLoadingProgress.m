//
//  KNLoadingProgress.m
//  LoadingDemo
//
//  Created by Touch on 4/26/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import "KNLoadingProgress.h"

@interface KNLoadingProgress ()

@property (nonatomic, assign) CGFloat diameter; // 直径
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSMutableArray *dots;

@end

@implementation KNLoadingProgress

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _diameter = 6.f;
        _padding = 4.f;
        _dots = [@[] mutableCopy];
    }
    return self;
}

- (void)setNumberOfDots:(NSInteger)numberOfDots {
    if (_numberOfDots == numberOfDots) {
        return;
    }
    _numberOfDots = numberOfDots;
    
    
    [_dots enumerateObjectsUsingBlock:^(CALayer *dotLayer, NSUInteger idx, BOOL *stop) {
        [dotLayer removeFromSuperlayer];
    }];
    [_dots removeAllObjects];
    
    for (int idx = 0; idx < _numberOfDots; idx++) {
        CGFloat widths = (_diameter + _padding) * _numberOfDots - _padding;
        CGFloat originX = (CGRectGetWidth(self.frame) - widths)/2 + idx*(_padding + _diameter);
        CGFloat originY = (CGRectGetHeight(self.frame) - _diameter) / 2;
        
        CAShapeLayer *dotLayer = [CAShapeLayer layer];
        dotLayer.frame = CGRectMake(originX, originY, _diameter, _diameter);
        dotLayer.cornerRadius = _diameter / 2;
        
        if (idx == 0) {
            dotLayer.backgroundColor = [UIColor redColor].CGColor;
        }
        else if (idx == 1) {
            dotLayer.backgroundColor = [UIColor greenColor].CGColor;
        }
        else {
            dotLayer.backgroundColor = [UIColor blueColor].CGColor;
        }
        
        [_dots addObject:dotLayer];
        [self.layer addSublayer:dotLayer];
    }
    
    [self startAnimation];
}

- (void)setColor:(UIColor *)color {
    if ([_color isEqual:color]) {
        return;
    }
    _color = color;
    
    for (CALayer *dotLayer in self.dots) {
        dotLayer.backgroundColor = _color.CGColor;
    }
}

- (void)startAnimation {
    [self stopAnimation];
    
    for (int idx = 0; idx < [self.dots count]; idx++) {
        CAShapeLayer *dotLayer = self.dots[idx];
        
        UIBezierPath *beazierPath = [UIBezierPath bezierPath];
        
        [beazierPath moveToPoint:CGPointMake(0, 0)];
        [beazierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
        
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        animation.duration = 2.5;
        animation.timeOffset = idx*0.2;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.15f :0.60f :0.85f :0.4f];
        animation.repeatCount = HUGE_VALF;
        animation.path = beazierPath.CGPath;
        
        [dotLayer addAnimation:animation forKey:nil];
    }
}

- (void)stopAnimation {
    [self.dots enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL * _Nonnull stop) {
        [layer removeAllAnimations];
    }];
}

@end
