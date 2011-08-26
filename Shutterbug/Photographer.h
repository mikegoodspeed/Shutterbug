//
//  Photographer.h
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright (c) 2011 Mike Goodspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photographer : NSManagedObject
{
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* photos;


+ (Photographer *)photographerWithFlickrData:(NSDictionary *)flickrData
                      inManagedObjectContext:(NSManagedObjectContext *)context;

@end
