//
//  PhotoViewController.m
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController()
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imgView;
@end

@implementation PhotoViewController

@synthesize photo = photo_;
@synthesize scrollView = scrollView_;
@synthesize imgView = imgView_;

- initWithPhoto:(Photo *)photo
{
    if ((self = [super init]))
    {
        self.title = photo.title;
        self.photo = photo;
    }
    return self;
}

- (void)dealloc
{
    [self.photo release];
    [super dealloc];
}

- (void)loadView
{
    NSData *imgData = [FlickrFetcher imageDataForPhotoWithURLString:self.photo.imageURL];
    UIImage *image = [UIImage imageWithData:imgData];
    self.imgView = [[UIImageView alloc] initWithImage:image];
    [self.imgView release];
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.scrollView release];
    
    self.scrollView.contentSize = image.size;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.zoomScale = 2.0;
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.imgView];
    self.view = self.scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Set up the default zoom and origin
    CGRect viewRect = self.scrollView.bounds;
    UIImage *image = self.imgView.image;
    CGFloat screenAspect = viewRect.size.width / viewRect.size.height;
    CGFloat imageAspect = image.size.width / image.size.height;
    
    CGRect zoomRect;
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    if (imageAspect > screenAspect)
    {
        zoomRect = CGRectMake(0, 0, height * screenAspect, height);
    }
    else
    {
        zoomRect = CGRectMake(0, 0, width, width / screenAspect);
    }
    zoomRect.origin.x = (width - zoomRect.size.width) / 2;
    zoomRect.origin.y = (height - zoomRect.size.height) / 2;
    
    [self.scrollView zoomToRect:zoomRect animated:NO];
    
    // Set the minimum zoom
    CGFloat xscale = viewRect.size.width / image.size.width;
    CGFloat yscale = viewRect.size.height / image.size.height;
    
    CGFloat minscale = (xscale < yscale ? xscale : yscale);
    self.scrollView.minimumZoomScale = minscale;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}

@end
