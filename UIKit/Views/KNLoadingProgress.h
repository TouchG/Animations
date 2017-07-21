//
//  KNLoadingProgress.h
//  LoadingDemo
//
//  Created by Touch on 4/26/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNLoadingProgress : UIView

@property (nonatomic, assign) NSInteger numberOfDots;
@property (nonatomic, strong) UIColor   *color;

- (void)startAnimation;
- (void)stopAnimation;

@end
