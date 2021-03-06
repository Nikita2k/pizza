// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.h instead.

#import <CoreData/CoreData.h>

extern const struct VenueAttributes {
	__unsafe_unretained NSString *checkins;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *venueID;
} VenueAttributes;

extern const struct VenueRelationships {
	__unsafe_unretained NSString *location;
} VenueRelationships;

@class Location;

@interface VenueID : NSManagedObjectID {}
@end

@interface _Venue : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) VenueID* objectID;

@property (nonatomic, strong) NSNumber* checkins;

@property (atomic) int32_t checkinsValue;
- (int32_t)checkinsValue;
- (void)setCheckinsValue:(int32_t)value_;

//- (BOOL)validateCheckins:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueID;

//- (BOOL)validateVenueID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Location *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _Venue (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCheckins;
- (void)setPrimitiveCheckins:(NSNumber*)value;

- (int32_t)primitiveCheckinsValue;
- (void)setPrimitiveCheckinsValue:(int32_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveVenueID;
- (void)setPrimitiveVenueID:(NSString*)value;

- (Location*)primitiveLocation;
- (void)setPrimitiveLocation:(Location*)value;

@end
