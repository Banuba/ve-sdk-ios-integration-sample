#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** Various helper method to improve Obj-C -- Swift interoperability. */
@interface BNBObjC : NSObject

/**
 * Call Obj-C method catching `NSException`s and convert then to `NSError`s.
 * Example:
 *     try BNBObjC.safeCall {
 *         // Some code
 *     }
 */
+ (BOOL)safeCall:(void (^)(void))tryBlock error:(__autoreleasing NSError**)error;

- (instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
