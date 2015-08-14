// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.m instead.

#import "_Location.h"

const struct LocationAttributes LocationAttributes = {
	.distance = @"distance",
};

const struct LocationRelationships LocationRelationships = {
	.venue = @"venue",
};

@implementation LocationID
@end

@implementation _Location

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Location";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Location" inManagedObjectContext:moc_];
}

- (LocationID*)objectID {
	return (LocationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"distanceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"distance"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic distance;

- (int32_t)distanceValue {
	NSNumber *result = [self distance];
	return [result intValue];
}

- (void)setDistanceValue:(int32_t)value_ {
	[self setDistance:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDistanceValue {
	NSNumber *result = [self primitiveDistance];
	return [result intValue];
}

- (void)setPrimitiveDistanceValue:(int32_t)value_ {
	[self setPrimitiveDistance:[NSNumber numberWithInt:value_]];
}

@dynamic venue;

@end

