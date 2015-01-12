//
//  MMHandPathHelper.h
//  LooseLeaf
//
//  Created by Adam Wulf on 1/12/15.
//  Copyright (c) 2015 Milestone Made, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDrawingGestureSilhouette : NSObject

@property (readonly) UIBezierPath* pointerFingerPath;
@property (readonly) CGPoint currentOffset;
@property (readonly) CAShapeLayer* handLayer;

-(void) moveToTouch:(UITouch*)touch;

@end