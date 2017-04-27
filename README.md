# Flash
[![Language](https://img.shields.io/badge/Swift-3-brightgreen.svg)](http://swift.org)
[![Build Status](https://travis-ci.org/nodes-vapor/flash.svg?branch=master)](https://travis-ci.org/nodes-vapor/flash)
[![codecov](https://codecov.io/gh/nodes-vapor/flash/branch/master/graph/badge.svg)](https://codecov.io/gh/nodes-vapor/flash)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/nodes-vapor/flash/master/LICENSE)

This package is to ease using flash message between your views

![image](https://cloud.githubusercontent.com/assets/1279756/21659442/fcfdd126-d2ca-11e6-8157-d6860aa02363.png)

# Installation

Update your `Package.swift` file.
```swift
.Package(url: "https://github.com/nodes-vapor/flash", majorVersion: 0)
```

### `main.swift`
```swift
import Flash
```

And add middleware either global
```swift
drop.middleware.append(FlashMiddleware())
```

or just to your route group

```swift
drop.group(FlashMiddleware()) { group in
   // Routes
}

```
### Usages

Apply flash on a response, which will be shown on next request
```swift
return Response(redirect: "/admin/users").flash(.error, "Failed to save user")
return Response(redirect: "/admin/users").flash(.success, "Successfuly saved")
return Response(redirect: "/admin/users").flash(.warning, "Updated user")
return Response(redirect: "/admin/users").flash(.info, "Email sent")
```

### Misc functions

```swift
// Add to request by string
try request.flash.add(custom: String, message: String)

// Add to request by enum
try request.flash.add(type: Helper.FlashType, message: String)

// Clear all flashes
try request.flash.clear()

// Show current flash messages again in next request
try request.flash.refresh()

```

### Example of HTML
```html
<!--Error-->
#if(request.storage._flash.error) {
    <div class="alert alert-danger alert-dismissible fade in to-be-animated-in" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <span class="fa fa-exclamation-circle"></span>
        #(request.storage._flash.error)
    </div>
}

<!--Success-->
#if(request.storage._flash.success) {
<div class="alert alert-success alert-dismissible fade in to-be-animated-in" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
    <span class="fa fa-check-circle"></span>
    #(request.storage._flash.success)
</div>
}

<!--Warning-->
#if(request.storage._flash.warning) {
<div class="alert alert-warning alert-dismissible fade in to-be-animated-in" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
    #(request.storage._flash.warning)
</div>
}

<!--Info-->
#if(request.storage._flash.info) {
<div class="alert alert-info alert-dismissible fade in to-be-animated-in" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
    #(request.storage._flash.info)
</div>
}

```
Add the flash html to one file and embed it in rest of your views or through a base layout
fx: `#embed("Layout/Partials/Elements/alerts")`
or
fx: `#extend("Layout/Base-Layout")`
