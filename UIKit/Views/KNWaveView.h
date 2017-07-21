//
//  KNWaveView.h
//  WaveDemo
//
//  Created by Touch on 4/24/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNWaveView : UIView

@property (nonatomic, assign) NSInteger     numberOfWaves;
@property (nonatomic, assign) CGFloat       waveAmplitude;
@property (nonatomic, assign) CGFloat       waveWidth;
@property (nonatomic, assign) CGFloat       phase;
@property (nonatomic, assign) CGFloat       offsetX;

@end
