### raylib-nim
Bindings for Raylib 6.2. Windows only.

#### How to use
```
$ mkdir hello-raylib
$ cd hello-raylib
$ git clone https://github.com/doccaico/raylib-nim.git
```

Add `--path:raylib-nim` to the command line, or include the following in config.nims.

#### config.nims
```
--path: "raylib-nim"
```

#### main.nim
```nim
import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window")
SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY)
  EndDrawing()
CloseWindow()
```

#### Build and Run
```sh
$ nim --path:raylib-nim r main.nim
# or
$ nim --path:.. r examples\core_basic_window.nim
# if you are using MSVC (cl.exe)
$ nim --cc:vcc --path:.. r examples\core_basic_window.nim
```

I was inspired by planetis-m's [naylib](https://github.com/planetis-m/naylib). Thank you.
