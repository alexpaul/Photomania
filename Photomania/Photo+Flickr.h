//
//  Photo+Flickr.h
//  Photomania
//
//  Created by Alex Paul on 3/16/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
