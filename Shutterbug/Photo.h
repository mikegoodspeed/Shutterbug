//
//  Photo.h
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright (c) 2011 Mike Goodspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject
{
}

+ (Photo *)photoWithFlickrData:(NSDictionary *)flickrData
        inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) Photographer * whoTook;


- (void)processImageDataWithBlock:(void (^)(NSData *imageData))processImage;
@end
