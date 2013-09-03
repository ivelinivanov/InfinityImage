//
//  Coordinate.m
//  InfinityImage
//
//  Created by Ivelin Ivanov on 8/23/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

-(id)initWithX:(CGFloat)x andY:(CGFloat)y
{
    if(self = [super init])
    {
        _x = x;
        _y = y;
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"X: %f, Y: %f", self.x, self.y];
}

@end
