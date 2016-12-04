1. In the _Project Navigator_ select your project.
2. Select the _Build Phases_ tab.
3. Expand the _Link Binary With Libraries_ section.
4. Drag the prebuilt `SDL2.framework` file to the section.
5. Press the + button and add the following system libraries:
    - `AudioToolbox.framework`
    - `AVFoundation.framework`
    - `CoreGraphics.framework`
    - `CoreMotion.framework`
    - `Foundation.framework`
    - `GameController.framework`
    - `OpenGLES.framework`
    - `QuartzCore.framework`
    - `UIKit.framework`
    - `libobjc.tbd`
6. Open the _Build Settings_ tab.
7. Add the path to the `SDL2.framework` file to _Framework Search Paths_.
8. Add your _SDL2_ source files to the project.