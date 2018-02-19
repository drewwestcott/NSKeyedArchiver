# NSKeyedArchiver
Test project to find out why sending a serialised object over WatchConnectivity causes a crash of 'NSInvalidUnarchiveOperationException'


One of my projects requires a custom class to be to the Apple Watch over WatchConnectivity using Application Context. However, although the class works correctly and encodes / decodes when saved in the iPhone Target to User Defaults, when sent to the WatchKit Extension I receive the following error on unarchiving.

"Terminating app due to uncaught exception 'NSInvalidUnarchiveOperationException', reason: '*** -[NSKeyedUnarchiver decodeObjectForKey:]: cannot decode object of class (NSKeyedArchiver.WorkoutSection) for key (NS.objects); the class may be defined in source code or a library that is not linked'"
