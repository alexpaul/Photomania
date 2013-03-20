//
//  Photo+Flickr.m
//  Photomania
//
//  Created by Alex Paul on 3/16/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photographer+Create.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || [matches count] > 1) { // There is an error if matches is nil or count is greater than 1
        // Handle the error
    }else if (![matches count]){ // couldn't find that photo in the database. Create one
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.unique = [photoDictionary[FLICKR_PHOTO_ID] description];
        photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
        photo.subtitle = [[photoDictionary valueForKey:FLICKR_PHOTO_DESCRIPTION] description];
        photo.imageURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        
        // Create the photographer relationship
        NSString *photographerName = [photoDictionary[FLICKR_PHOTO_OWNER]description];
        Photographer *photographer = [Photographer photographerWithName:photographerName inManagedObjectContext:context];
        photo.whoTook = photographer; 
    }else{ // There is one match in the database
        photo = [matches lastObject];
    }
    
    return photo; 
}

@end
