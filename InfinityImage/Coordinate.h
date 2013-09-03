//
//  Coordinate.h
//  InfinityImage
//
//  Created by Ivelin Ivanov on 8/23/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

-(id)initWithX:(CGFloat)x andY:(CGFloat)y;

@end
