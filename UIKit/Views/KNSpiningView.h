//
//  KNSpiningView.h
//  tjk
//
//  Created by Touch on 4/27/16.
//  Copyright © 2016 kuner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNSpiningView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)startSpining;

- (void)stopSpining;

@end
