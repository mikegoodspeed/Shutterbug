//
//  Photo.m
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright (c) 2011 Mike Goodspeed. All rights reserved.
//

#import "Photo.h"
#import "Photographer.h"
#import "FlickrFetcher.h"


@implementation Photo
@dynamic imageURL;
@dynamic title;
@dynamic uniqueId;
@dynamic whoTook;

+ (Photo *)photoWithFlickrData:(NSDictionary *)flickrData
        inManagedObjectContext:(NSManagedObjectContext *)context
{
//    NSLog(@"flickrData=%@", flickrData);
    Photo *photo = NULL;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Photo"
                                 inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId = %@",
                         [flickrData objectForKey:@"id"]];
    NSError *error = NULL;
    photo = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    if (!error && !photo)
    {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                              inManagedObjectContext:context];
        photo.uniqueId = [flickrData objectForKey:@"id"];
        photo.title = [flickrData objectForKey:@"title"];
        photo.imageURL = [FlickrFetcher 
                          urlStringForPhotoWithFlickrInfo:flickrData
                          format:FlickrFetcherPhotoFormatLarge];
        photo.whoTook = [Photographer photographerWithFlickrData:flickrData
                                          inManagedObjectContext:context];
    }
    return photo;
}


- (void)processImageDataWithBlock:(void (^)(NSData *imageData))processImage
{
    NSString *url = self.imageURL;
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("Flikr downloader in Photo", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *imageData = [FlickrFetcher imageDataForPhotoWithURLString:url];
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
    dispatch_release(downloadQueue);
}

@end
