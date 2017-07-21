//
//  KNWaveView.m
//  WaveDemo
//
//  Created by Touch on 4/24/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import "KNWaveView.h"

static NSString *waveAnimationKey   = @"waveAnimationKey";

@interface KNWaveView ()

@property (nonatomic, strong) NSMutableArray    *waves;
@property (nonatomic, strong) CADisplayLink     *displayLink;

@end


@implementation KNWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfWaves = 3;
        _waveAmplitude = 8.f;
        _offsetX = 0.0f;
        
        _waveWidth = CGRectGetWidth(frame) * 1.2;
        _phase = _waveWidth / _numberOfWaves;
        
        _waves = [@[] mutableCopy];
        
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI {
    
    for (int idx = 0; idx < _numberOfWaves; idx++) {
        CAShapeLayer *waveLayer = [[CAShapeLayer alloc] init];
        
        CGFloat alpha = (idx + 1)*1.0 / _numberOfWaves;
        UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
        waveLayer.fillColor = color.CGColor;
        [self.layer addSublayer:waveLayer];
        
        [_waves addObject:waveLayer];
    }
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWaves)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateWaves {
    _offsetX -= 0.05;
    
    CGFloat maxX = self.frame.size.width;
    CGFloat maxY = self.frame.size.height;
    CGFloat period = 2 * M_PI / self.waveWidth;
    
    
    for (int idx = 0; idx < _numberOfWaves; idx++) {
        
        UIBezierPath *beazierPath = [UIBezierPath bezierPath];
        
        [beazierPath moveToPoint:CGPointMake(0, 0)];
        
        for (CGFloat x = 0.0f; x < self.frame.size.width + _waveWidth; x++) {
            /**
             *  y = A * sin(x * B + C)
             */
            CGFloat pointX = x;
            CGFloat pointY = _waveAmplitude * sinf(period * (x + self.phase * idx) + _offsetX);
            
            [beazierPath addLineToPoint:CGPointMake(pointX, pointY)];
        }
        
        [beazierPath addLineToPoint:CGPointMake(maxX, maxY)];
        [beazierPath addLineToPoint:CGPointMake(0, maxY)];
        
        CAShapeLayer *waveLayer = self.waves[idx];
        waveLayer.path = beazierPath.CGPath;
    }
}

- (void)dealloc {
    [_displayLink invalidate];
}


@end
