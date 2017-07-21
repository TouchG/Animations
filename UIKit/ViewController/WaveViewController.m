//
//  WaveViewController.m
//  UIKit
//
//  Created by Touch on 9/8/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import "WaveViewController.h"
#import "KNWaveView.h"

@interface WaveViewController ()

@property (nonatomic, strong) KNWaveView *waveView;

@end

@implementation WaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.596 green:0.540 blue:1.000 alpha:1.000];
    
    _waveView = [[KNWaveView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 100)];
    [self.view addSubview:_waveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
