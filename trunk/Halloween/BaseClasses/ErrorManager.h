@interface ErrorManager : NSObject
{
	
}

+ (ErrorManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)ERROR:(char*)msg value:(int)val;
- (void)AddTrack:(char*)msg value:(int)val;
- (void)ClearTrack;

@end
