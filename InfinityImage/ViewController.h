//
//  ViewController.h
//  InfinityImage
//
//  Created by Ivelin Ivanov on 8/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "InfiniteScrollView.h"
#import "Constants.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet InfiniteScrollView *scrollView;

@end
