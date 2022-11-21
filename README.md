# Thread-safe-Singleton
Thread-safe-Singleton from a course by Karoly Nyisztor "Practical Design Patterns in Swift".
Resolving race condition by using custom concurrent queue with .barrier on setting value. This solution is more performant than the one that uses just a serial queue, because value receving is concurrent.
