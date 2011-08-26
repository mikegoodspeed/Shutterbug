//
//  Photographer.m
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright (c) 2011 Mike Goodspeed. All rights reserved.
//

#import "Photographer.h"


@implementation Photographer
@dynamic name;
@dynamic photos;

+ (Photographer *)photographerWithFlickrData:(NSDictionary *)flickrData
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = NULL;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Photographer"
                                 inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@",
                         [flickrData objectForKey:@"ownername"]];
    NSError *error = NULL;
    photographer = [[context executeFetchRequest:request error:&error]
                    lastObject];
    [request release];
    if (!error && !photographer)
    {
        photographer = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Photographer"
                        inManagedObjectContext:context];
        photographer.name = [flickrData objectForKey:@"ownername"];
    }
    return photographer;
}

- (void)addPhotosObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"photos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"photos"] addObject:value];
    [self didChangeValueForKey:@"photos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removePhotosObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"photos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"photos"] removeObject:value];
    [self didChangeValueForKey:@"photos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addPhotos:(NSSet *)value {    
    [self willChangeValueForKey:@"photos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"photos"] unionSet:value];
    [self didChangeValueForKey:@"photos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removePhotos:(NSSet *)value {
    [self willChangeValueForKey:@"photos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"photos"] minusSet:value];
    [self didChangeValueForKey:@"photos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
