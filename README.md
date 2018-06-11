# Flash ⚡️
[![Swift Version](https://img.shields.io/badge/Swift-4.1-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-3-30B6FC.svg)](http://vapor.codes)
[![Circle CI](https://circleci.com/gh/nodes-vapor/flash/tree/master.svg?style=shield)](https://circleci.com/gh/nodes-vapor/flash)
[![codebeat badge](https://codebeat.co/badges/10cffe07-3d4f-420c-adb9-a98529671bfa)](https://codebeat.co/projects/github-com-nodes-vapor-flash-master)
[![codecov](https://codecov.io/gh/nodes-vapor/flash/branch/master/graph/badge.svg)](https://codecov.io/gh/nodes-vapor/flash)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/nodes-vapor/flash)](http://clayallsopp.github.io/readme-score?url=https://github.com/nodes-vapor/flash)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/nodes-vapor/flash/master/LICENSE)

This package allows you to display Flash messages between your views.

![image](https://github.com/nodes-vapor/flash/blob/master/flash.png)

# Installation

Update your `Package.swift` file.
```swift
.package(url: "https://github.com/nodes-vapor/flash.git", from: "2.0.0-beta")
```

## Getting started 🚀

First make sure that you've imported Flash everywhere when needed:

```swift
import Flash
```

### Adding the provider

```swift
public func register(_ services: inout Services) throws {
    try services.register(FlashProvider())
}
```

### Adding the middleware

You can either add the Flash middleware globally by doing:

```swift
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    var middlewares = MiddlewareConfig()
    middlewares.use(FlashMiddleware.self)
    middlewares.use(SessionsMiddleware.self)
    services.register(middlewares)
}
```

Alternatively, you can add the middleware to individual route groups where needed:

```swift
router.group(FlashMiddleware()) { router in
    // .. routes
}
```

Please note that the `SessionsMiddleware` needs to be added to the same route groups where Flash is added.

### Adding the Leaf tag

In order to render Flash messages, you will need to add the Flash leaf tag:

```swift
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    services.register { _ -> LeafTagConfig in
        var tags = LeafTagConfig.default()
        tags.use(FlashTag(), as: "flash")
        return tags
    }
}
```

## Using Flash messages

With Flash set up, you are now able to redirect while adding a Flash message, given a `Request`:

```swift
request.redirect(to: "/users").flash(.success, "Successfully saved")
request.redirect(to: "/users").flash(.info, "Email sent")
request.redirect(to: "/users").flash(.warning, "Updated user")
request.redirect(to: "/users").flash(.error, "Something went wrong")
```

### Example of HTML

This package comes with a Leaf tag that makes it easy and convenient to display Flash messages. We suggest to use the [Bootstrap package](https://github.com/nodes-vapor/bootstrap) for rendering Bootstrap elements, but this package does not depend on it.

It's possible to loop through the different kinds of messages using:

- `all`: All Flash messages no matter the kind.
- `successes`: All Flash messages of type `success`.
- `information`: All Flash messages of type `info`.
- `warnings`: All Flash messages of type `warning`.
- `errors`: All Flash messages of type `error`.

Further, using the `message` property you will be able to pull out the message of the Flash message. You can also get the kind by using the `kind` property. This property will hold one of the following values: `success`, `info`, `warning` or `error`. Lastly, you can use the `bootstrapClass` to get the relevant Bootstrap class:

- `success` will return `success`.
- `info` will return `info`.
- `warning` will return `warning`.
- `error` will return `danger`.

#### Not using the Bootstrap package

Without using any dependencies, this is how Flash messages could be rendered:

```html
<div class="alerts">
#flash() {
    #for(flash in all) {
        Message: #(flash.message)
        Type: #(flash.kind)
    }
}
</div>
```

#### Using the Bootstrap package

The below example uses the Vapor 3 [Bootstrap package](https://github.com/nodes-vapor/bootstrap) for generating the alert html.

```html
<div class="alerts">
#flash() {
    #for(flash in all) {
        #bs:alert(flash.bootstrapClass) {
            #(flash.message)
        }
    }
}
</div>

```

Add the Flash html to one file and embed it in rest of your views or through a base layout, e.g.: `#embed("alerts")`.


## 🏆 Credits

This package is developed and maintained by the Vapor team at [Nodes](https://www.nodesagency.com).
The package owner for this project is [Brett](https://github.com/brettrtoomey).


## 📄 License

This package is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
