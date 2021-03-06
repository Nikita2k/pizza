// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.m instead.

#import "_Venue.h"

const struct VenueAttributes VenueAttributes = {
	.checkins = @"checkins",
	.name = @"name",
	.venueID = @"venueID",
};

const struct VenueRelationships VenueRelationships = {
	.location = @"location",
};

@implementation VenueID
@end

@implementation _Venue

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Venue";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:moc_];
}

- (VenueID*)objectID {
	return (VenueID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"checkinsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"checkins"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic checkins;

- (int32_t)checkinsValue {
	NSNumber *result = [self checkins];
	return [result intValue];
}

- (void)setCheckinsValue:(int32_t)value_ {
	[self setCheckins:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCheckinsValue {
	NSNumber *result = [self primitiveCheckins];
	return [result intValue];
}

- (void)setPrimitiveCheckinsValue:(int32_t)value_ {
	[self setPrimitiveCheckins:[NSNumber numberWithInt:value_]];
}

@dynamic name;

@dynamic venueID;

@dynamic location;

@end

