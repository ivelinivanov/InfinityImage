//
//  ViewController.m
//  InfinityImage
//
//  Created by Ivelin Ivanov on 8/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager* manager;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.manager = [[CMMotionManager alloc] init];
    self.manager.accelerometerUpdateInterval = kAccelerometerUpdateInterval;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [self.manager startAccelerometerUpdatesToQueue: queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
    {
        CGPoint newOffset = self.scrollView.contentOffset;
        
        newOffset.x += accelerometerData.acceleration.x * kAccelerationSpeed;
        newOffset.y += accelerometerData.acceleration.y * kAccelerationSpeed;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.contentOffset = newOffset;
        });
    }];
}


@end
