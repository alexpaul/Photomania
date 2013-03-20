//
//  Photographer+Create.m
//  Photomania
//
//  Created by Alex Paul on 3/17/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "Photographer+Create.h"

@implementation Photographer (Create)

+ (Photographer *)photographerWithName:(NSString *)name
inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = nil;
    
    if (name.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count] > 1) { // There is an error if matches is nil or count is greater than 1
            // Handle the error
        }else if (![matches count]){ // couldn't find that photo in the database. Create one
            photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
            photographer.name = name;
        }else{ // There is one match in the database
            photographer = [matches lastObject];
        }
    }
    
    return photographer;
}

@end
