//
//  SpiningViewController.m
//  UIKit
//
//  Created by Touch on 9/8/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import "SpiningViewController.h"
#import "KNSpiningView.h"

@interface SpiningViewController ()

@property (nonatomic, strong) KNSpiningView *spinView;

@end

@implementation SpiningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat margin = 20.f;
    CGFloat size = CGRectGetWidth(self.view.frame) - 2 * margin;
    
    _spinView = [[KNSpiningView alloc] initWithFrame:CGRectMake(margin, 100, size, size)];
    [self.view addSubview:_spinView];
    
    [_spinView startSpining];
    
//    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
}

#pragma mark -
- (void)stopAnimation {
    [_spinView stopSpining];
}

- (void)drawFanView {
    CGFloat progress = _spinView.progress;
    progress += 0.01;
    
    if (progress > 1.0) {
        progress = 0.0;
    }
    
    _spinView.progress = progress;
}

@end
