//
//  KNSpiningView.m
//  tjk
//
//  Created by Touch on 4/27/16.
//  Copyright © 2016 kuner. All rights reserved.
//

#import "KNSpiningView.h"

#define DEGREES_TO_RADIANS(angle)   ((angle) / 180 * M_PI)

@interface KNSpiningView ()<CAAnimationDelegate>
{
    BOOL                _forceStop;
    
    BOOL                _moveStart;
    CABasicAnimation    *_strokeStartAnimation;
    CABasicAnimation    *_strokeEndAnimation;
}

@property (nonatomic, strong) CAShapeLayer *innerShape;

@property (nonatomic, strong) CAShapeLayer *progressShape;

@end

@implementation KNSpiningView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _innerShape = [CAShapeLayer layer];
        _innerShape.fillColor = [UIColor clearColor].CGColor;
        _innerShape.strokeColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:_innerShape];
        
        
        _progressShape = [CAShapeLayer layer];
        
        _progressShape.fillColor    = [UIColor clearColor].CGColor;
        _progressShape.strokeColor  = [UIColor purpleColor].CGColor;
        
        [self.layer addSublayer:_progressShape];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat minSide = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    CGFloat diameter = minSide - 2*8;
    CGFloat radius = diameter / 2.0f;
    
    CGRect rect = CGRectMake((CGRectGetWidth(self.bounds) / 2.0f) - (radius / 2.0f),
                             (CGRectGetHeight(self.bounds) / 2.0f) - (radius / 2.0f),
                             radius,
                             radius);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    self.progressShape.path = bezierPath.CGPath;
    self.progressShape.lineWidth = radius;
    
    self.innerShape.path = bezierPath.CGPath;
    self.innerShape.lineWidth = radius;
}

- (void)startSpining {
    [self _addStrokeAnimation:NO];
}

- (void)stopSpining {
    _forceStop = YES;
    [self.progressShape removeAllAnimations];
}

- (void)_addStrokeAnimation:(BOOL)moveStart {
    if (_forceStop) {
        return;
    }
    
    if (moveStart) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 1.5;
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:1.0f];
        
        animation.delegate = self;
        [self.innerShape addAnimation:animation forKey:nil];
    }
    else {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 1.5;
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat:1.0f];
        
        animation.delegate = self;
        [self.progressShape addAnimation:animation forKey:nil];
    }
}

#pragma mark -
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if (_moveStart) {
            [self.layer insertSublayer:self.progressShape above:self.innerShape];
        }
        else {
            [self.layer insertSublayer:self.innerShape above:self.progressShape];
        }
        
        _moveStart = !_moveStart;
        [self _addStrokeAnimation:_moveStart];
    }
}

- (void)setProgress:(CGFloat)progress {
    if ([self pinnedProgress:progress] != _progress) {
        
        _progress = [self pinnedProgress:progress];
        self.progressShape.strokeEnd = _progress;
    }
}

- (CGFloat)pinnedProgress:(float)progress {
    CGFloat pinnedProgress = MAX(0.0f, progress);
    pinnedProgress = MIN(1.0f, pinnedProgress);
    
    return pinnedProgress;
}

@end
