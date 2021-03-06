//
//  MMCachedPreviewManager.m
//  LooseLeaf
//
//  Created by Adam Wulf on 6/6/14.
//  Copyright (c) 2014 Milestone Made, LLC. All rights reserved.
//

#import "MMCachedPreviewManager.h"
#import "MMBlockOperation.h"
#import "NSThread+BlockAdditions.h"


@interface MMImageView : UIImageView

@end


@implementation MMImageView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //        self.layer.borderColor = [UIColor redColor].CGColor;
        //        self.layer.borderWidth = 100;
    }
    return self;
}

- (void)setHidden:(BOOL)hidden {
    //    DebugLog(@"setting %p hidden: %d", self, hidden);
    [super setHidden:hidden];
}

@end


@implementation MMCachedPreviewManager {
    NSMutableArray* arrayOfImageViews;
    NSMutableArray* toDealloc;
    NSOperationQueue* queue;
}

static MMCachedPreviewManager* _instance = nil;

- (id)init {
    if (_instance)
        return _instance;
    if ((self = [super init])) {
        _instance = self;
        arrayOfImageViews = [NSMutableArray array];
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        toDealloc = [NSMutableArray array];
    }
    return _instance;
}

+ (MMCachedPreviewManager*)sharedInstance {
    if (!_instance) {
        _instance = [[MMCachedPreviewManager alloc] init];
    }
    return _instance;
}


- (UIImageView*)requestCachedImageViewForView:(UIView*)aView {
    if ([arrayOfImageViews count]) {
        UIImageView* cachedImgView = [arrayOfImageViews lastObject];
        [arrayOfImageViews removeLastObject];
        cachedImgView.frame = aView.bounds;
        return cachedImgView;
    }
    UIImageView* cachedImgView = [[MMImageView alloc] initWithFrame:aView.bounds];
    cachedImgView.frame = aView.bounds;
    cachedImgView.contentMode = UIViewContentModeScaleAspectFill;
    cachedImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cachedImgView.clipsToBounds = YES;
    cachedImgView.opaque = YES;
    cachedImgView.backgroundColor = [UIColor whiteColor];
    return cachedImgView;
}

- (void)giveBackCachedImageView:(UIImageView*)imageView {
    [imageView removeFromSuperview];
    imageView.image = nil;
    if ([arrayOfImageViews count] < 3) {
        [arrayOfImageViews addObject:imageView];
    } else {
        @synchronized(self) {
            [toDealloc addObject:imageView];
        }
        [queue addOperationWithBlock:^{
            @synchronized(self) {
                [toDealloc removeLastObject];
            }
        }];
    }
}

@end
