# Yet Another SwiftLog

YASL is a module-based logging system for Swift applications that abstracts logging proccess. It is mainly influenced by [SwiftLog](https://github.com/apple/swift-log
)
## Getting started
### Default setup flow
Run following lines of code to configure logging system (it's better to configure logging as early as possible)
```swift
// Init and configure backends in entrypoint of your app.
let fileBackend = ... 
let anotherBackend = ...
let backend = MultiplexLogBackend([fileBackend, anotherBackend])

// Provide backend factory method.
LoggingSystem.bootstrap { backend }
```

### Usage
```swift
class Component { 
    let logger = Logger(source: "Component")
    
    func doAction() { 
        logger.debug("doAction() is going to be performed.")
        ...
        logger.info("doAction() is going to be finished.")
    }
}
```

Log templated message:
```swift
logger.error("Error happend in method doAction(). Description: %@", err.localizedDescription)
```

The method `logger.debug("Message")` is shorthand for `logger.log(level: .debug, message: "Message")`.
