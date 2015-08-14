// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.h instead.

#import <CoreData/CoreData.h>

extern const struct LocationAttributes {
	__unsafe_unretained NSString *distance;
} LocationAttributes;

extern const struct LocationRelationships {
	__unsafe_unretained NSString *venue;
} LocationRelationships;

@class Venue;

@interface LocationID : NSManagedObjectID {}
@end

@interface _Location : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LocationID* objectID;

@property (nonatomic, strong) NSNumber* distance;

@property (atomic) int32_t distanceValue;
- (int32_t)distanceValue;
- (void)setDistanceValue:(int32_t)value_;

//- (BOOL)validateDistance:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Venue *venue;

//- (BOOL)validateVenue:(id*)value_ error:(NSError**)error_;

@end

@interface _Location (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveDistance;
- (void)setPrimitiveDistance:(NSNumber*)value;

- (int32_t)primitiveDistanceValue;
- (void)setPrimitiveDistanceValue:(int32_t)value_;

- (Venue*)primitiveVenue;
- (void)setPrimitiveVenue:(Venue*)value;

@end
