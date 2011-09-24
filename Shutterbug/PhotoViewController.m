//
//  PhotoViewController.m
//  Shutterbug
//
//  Created by Mike Goodspeed on 9/24/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController()
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation PhotoViewController

@synthesize photo = _photo;
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize spinner = _spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [_imageView release];
    [_spinner release];
    [_photo release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.spinner startAnimating];
    [self.photo processImageDataWithBlock:^(NSData *imageData){
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.scrollView.contentSize = image.size;
        [self.spinner stopAnimating];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.imageView = nil;
    self.spinner = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
