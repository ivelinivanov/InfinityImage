//
//  InfiniteScrollView.m
//  InfinityImage
//
//  Created by Ivelin Ivanov on 8/22/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "InfiniteScrollView.h"

@interface InfiniteScrollView ()

@property (strong, nonatomic) UIView *imageContainerView;
@property (strong, nonatomic) NSMutableArray *coordinates;
@property (strong, nonatomic) NSMutableArray *visibleImages;
@property (strong, nonatomic) NSMutableArray *reusableImages;

@end


@implementation InfiniteScrollView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        CGFloat xOrigin = 0.0f;
        CGFloat yOrigin = 0.0f;
        
        self.contentSize = CGSizeMake(kImageNumber * kImageWidth, kImageNumber * kImageHeight);
        
        self.coordinates = [[NSMutableArray alloc] init];
        self.visibleImages = [[NSMutableArray alloc] init];
        self.reusableImages = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < kImageNumber; i++)
        {
            NSMutableArray *subArray = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < kImageNumber; j++)
            {
                Coordinate *coordinate = [[Coordinate alloc] initWithX:xOrigin andY:yOrigin];
                [subArray addObject:coordinate];
                
                xOrigin += kImageWidth;
            }
            
            xOrigin = 0.0f;
            yOrigin += kImageHeight;
            
            [self.coordinates addObject:subArray];
        }
        
        _imageContainerView = [[UIView alloc] init];
        
        self.imageContainerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
        
        [self addSubview:self.imageContainerView];
        
        [self.imageContainerView setUserInteractionEnabled:NO];
        
    }
    
    return self;
}

#pragma mark - Layout

-(void)recenterIfNecessary
{
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentWidth = self.contentSize.width;
    CGFloat centerOffsetX = (contentWidth - self.bounds.size.width) / 2.0;
    CGFloat distanceFromCenterX = fabsf(currentOffset.x - centerOffsetX);
    
    CGFloat contentHeight = self.contentSize.height;
    CGFloat centerOffsetY = (contentHeight - self.bounds.size.height) / 2.0;
    CGFloat distanceFromCenterY = fabsf(currentOffset.y - centerOffsetY);
    
    if (distanceFromCenterX > (contentWidth / 5.0))
    {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
    }
    
    if (distanceFromCenterY > (contentHeight / 5.0))
    {
        self.contentOffset = CGPointMake(currentOffset.x, centerOffsetY);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self recenterIfNecessary];
    
    [self retreiveAliveHiddenTiles];
    [self tileImages];
}

#pragma mark - Image Tiling

-(UIImageView *)getReusableImage
{
    if ([self.reusableImages count] != 0)
    {
        UIImageView *image = [self.reusableImages lastObject];
        [self.reusableImages removeLastObject];
        return image;
    }
    else
    {
        return [self insertImage];
    }
}

- (UIImageView *)insertImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    imageView.image = [UIImage imageNamed:@"pattern.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.imageContainerView addSubview:imageView];
    
    return imageView;
}

-(void)tileImages
{
    for (int i = 0; i < kImageNumber; i++)
    {
        for (int j = 0; j < kImageNumber; j++)
        {
            Coordinate *coordinate = (Coordinate *)self.coordinates[i][j];
            
            CGRect newFrame = CGRectMake(coordinate.x, coordinate.y, kImageWidth, kImageHeight);
            
            if(CGRectIntersectsRect(newFrame, self.bounds))
            {
                UIImageView *image = [self getReusableImage];
            
                image.frame = newFrame;
                [self.visibleImages addObject:image];
            
                [self.imageContainerView addSubview:image];
                
            }
        }
    }
}

-(void)retreiveAliveHiddenTiles
{
    for (int i = 0; i < [self.visibleImages count]; i++)
    {
        UIImageView *image = (UIImageView *)self.visibleImages[i];
        
        [image removeFromSuperview];
        [self.visibleImages removeObject:image];
        [self.reusableImages addObject:image];
    }
}

@end

