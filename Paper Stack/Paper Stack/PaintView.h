//
//  PaintView.h
//  PaintingSample
//
//  Created by Sean Christmann on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PaintableViewDelegate.h"
#import "PaintTouchViewDelegate.h"
#import <DrawKit-iOS/DrawKit-iOS.h>

@class SLPaperView;

@interface PaintView : UIView<PaintTouchViewDelegate> {
    void *cacheBitmap;
    CGContextRef cacheContext;
    CGLayerRef cacheCGLayer;
    CGFloat hue;
    NSObject<PaintableViewDelegate>* delegate;
    UIBezierPath* clipPath;


    UIBezierPath* cachedClipPath;
    
    
    SLPaperView* page;
    float scaleFactor;
    CGSize contextSize;
    void *rawData;
    
    // debug
    CGImageRef cgImage;
    UIImageView* imageView;
    
}

@property (nonatomic, assign) SLPaperView* page;

@property (nonatomic, assign) NSObject<PaintableViewDelegate>* delegate;

@property (nonatomic, retain) UIBezierPath* clipPath;

-(void) updateClipPath;

@end
