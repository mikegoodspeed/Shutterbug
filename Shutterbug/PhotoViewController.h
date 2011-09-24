//
//  PhotoViewController.h
//  Shutterbug
//
//  Created by Mike Goodspeed on 9/24/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoViewController : UIViewController
{
    Photo *_photo;
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIImageView *_imageView;
    IBOutlet UIActivityIndicatorView *_spinner;
}

@property (nonatomic, retain) Photo *photo;

@end
