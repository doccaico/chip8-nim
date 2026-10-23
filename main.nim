import std / [random]

import raylib

const
  MemorySize = 4096
  RegisterCount = 16
  StackSize = 16
  ScreenWidth = 64
  ScreenHeight = 32
  Scale = 15         # Screen scale factor (64*15 = 960, 32*15 = 480)

type
  Chip8 = object
    memory: array[MemorySize, uint8]
    v: array[RegisterCount, uint8]                   # General purpose registers V0-VF
    i: uint16                                        # Index register
    pc: uint16                                       # Program counter
    sp: uint8                                        # Stack pointer
    stack: array[StackSize, uint16]                  # Stack

    delayTimer: uint8
    soundTimer: uint8

    display: array[ScreenWidth * ScreenHeight, bool] # 64x32 monochrome display
    keypad: array[16, bool]                          # 16-key keypad state

    drawFlag: bool                                   # Screen redraw flag

const FontSet: array[80, uint8] = [
  0xF0, 0x90, 0x90, 0x90, 0xF0, # 0
  0x20, 0x60, 0x20, 0x20, 0x70, # 1
  0xF0, 0x10, 0xF0, 0x80, 0xF0, # 2
  0xF0, 0x10, 0xF0, 0x10, 0xF0, # 3
  0x90, 0x90, 0xF0, 0x10, 0x10, # 4
  0xF0, 0x80, 0xF0, 0x10, 0xF0, # 5
  0xF0, 0x80, 0xF0, 0x90, 0xF0, # 6
  0xF0, 0x10, 0x20, 0x40, 0x40, # 7
  0xF0, 0x90, 0xF0, 0x90, 0xF0, # 8
  0xF0, 0x90, 0xF0, 0x10, 0xF0, # 9
  0xF0, 0x90, 0xF0, 0x90, 0x90, # A
  0xE0, 0x90, 0xE0, 0x90, 0xE0, # B
  0xF0, 0x80, 0x80, 0x80, 0xF0, # C
  0xE0, 0x90, 0x90, 0x90, 0xE0, # D
  0xF0, 0x80, 0xF0, 0x80, 0xF0, # E
  0xF0, 0x80, 0xF0, 0x80, 0x80  # F
]

proc init(c: var Chip8)
proc loadROM(c: var Chip8, filename: string)
proc emulateCycle(c: var Chip8)

proc init(c: var Chip8) =
  c.pc = 0x200 # CHIP-8 programs normally start at 0x200
  c.i = 0
  c.sp = 0

  # Copy font set into memory
  for i in 0..<80:
    c.memory[0x50 + i] = FontSet[i]

proc loadROM(c: var Chip8, filename: string) =
  let rom = readFile(filename)
  echo "ROM loaded: ", filename, " (Size: ", rom.len, " bytes)"
  for i in 0..<rom.len:
    if 0x200 + i < MemorySize:
      c.memory[0x200 + i] = rom[i].uint8

proc emulateCycle(c: var Chip8) =
  # Guard against PC going out of memory bounds (crash prevention)
  if c.pc >= MemorySize - 1:
    c.pc = 0x200
    return

  # 1. Fetch (retrieve 2 bytes and combine into an opcode)
  let opcode = c.memory[c.pc].uint16 shl 8 or c.memory[c.pc + 1].uint16
  c.pc += 2

  # Extract components from the opcode
  let 
    nnn = opcode and 0x0FFF'u16
    n   = uint8(opcode and 0x000F'u16)
    x   = uint8((opcode and 0x0F00'u16) shr 8)
    y   = uint8((opcode and 0x00F0'u16) shr 4)
    kk  = uint8(opcode and 0x00FF'u16)

  # 2. Decode & Execute
  case opcode and 0xF000
  of 0x0000:
    if opcode == 0x00E0: # Clear screen
      for i in 0 ..< c.display.len:
        c.display[i] = false
      c.drawFlag = true
    elif opcode == 0x00EE: # Return from subroutine
      c.sp -= 1
      c.pc = c.stack[c.sp]
  of 0x1000: # 1NNN: Jump
    c.pc = nnn
  of 0x2000: # 2NNN: Call subroutine
    c.stack[c.sp] = c.pc
    c.sp += 1
    c.pc = nnn
  of 0x3000: # 3XKK: Skip next instruction if VX == KK
    if c.v[x] == kk: c.pc += 2
  of 0x4000: # 4XKK: Skip next instruction if VX != KK
    if c.v[x] != kk: c.pc += 2
  of 0x5000: # 5XY0: Skip next instruction if VX == VY
    if c.v[x] == c.v[y]: c.pc += 2
  of 0x6000: # 6XKK: VX = KK
    c.v[x] = kk
  of 0x7000: # 7XKK: VX += KK
    c.v[x] += kk
  of 0x8000:
    case n
    of 0x0: c.v[x] = c.v[y]
    of 1: c.v[x] = c.v[x] or c.v[y]
    of 2: c.v[x] = c.v[x] and c.v[y]
    of 3: c.v[x] = c.v[x] xor c.v[y]
    of 4: 
      let sum: int = c.v[x].int + c.v[y].int
      c.v[0xF] = if sum > 255: 1 else: 0
      c.v[x] = (sum and 0xFF).uint8
    of 5:
      c.v[0xF] = if c.v[x] > c.v[y]: 1 else: 0
      c.v[x] -= c.v[y]
    of 6:
      c.v[0xF] = c.v[x] and 0x1
      c.v[x] = c.v[x] shr 1
    of 7:
      c.v[0xF] = if c.v[y] > c.v[x]: 1 else: 0
      c.v[x] = c.v[y] - c.v[x]
    of 0xE:
      c.v[0xF] = (c.v[x] and 0x80) shr 7
      c.v[x] = c.v[x] shl 1
    else: discard
  of 0x9000: # 9XY0: Skip next instruction if VX != VY
    if c.v[x] != c.v[y]: c.pc += 2
  of 0xA000: # ANNN: I = NNN
    c.i = nnn
  of 0xB000: # BNNN: PC = V0 + NNN
    c.pc = nnn + c.v[0].uint16
  of 0xC000: # CXKK: VX = random & KK
    c.v[x] = rand(255).uint8 and kk
  of 0xD000: # DXYN: Draw sprite at (Vx, Vy) with height N
    let 
      vx = c.v[x] mod ScreenWidth
      vy = c.v[y] mod ScreenHeight
      height = n.int

    c.v[0xF] = 0
    for row in 0..<height:
      let yCoord = (vy.int + row) mod ScreenHeight
      let pixelRow = c.memory[c.i + row.uint16]

      for col in 0..<8:
        let xCoord = (vx.int + col) mod ScreenWidth
        let bitMask = 0x80'u8 shr col

        if (pixelRow and bitMask) != 0:
          let idx = yCoord * ScreenWidth + xCoord
          if c.display[idx]:
            c.v[0xF] = 1
          c.display[idx] = not c.display[idx]
    c.drawFlag = true
  of 0xE000:
    let key = c.v[x]
    if kk == 0x9E: # EX9E: Skip next instruction if key VX is pressed
      if c.keypad[key]: c.pc += 2
    elif kk == 0xA1: # EXA1: Skip next instruction if key VX is not pressed
      if not c.keypad[key]: c.pc += 2
  of 0xF000:
    case kk
    of 0x07: c.v[x] = c.delayTimer
    of 0x0A: # FX0A: Wait for a key press, store key value in VX
      var pressed = false
      for i in 0..<16:
        if c.keypad[i]:
          c.v[x] = i.uint8
          pressed = true
          break
      if not pressed:
        c.pc -= 2 # Re-execute this instruction if no key is pressed
    of 0x15: c.delayTimer = c.v[x]
    of 0x18: c.soundTimer = c.v[x]
    of 0x1E: c.i += c.v[x].uint16
    of 0x29: c.i = 0x050 + c.v[x].uint16 * 5 # Font sprite address
    of 0x33: # Store BCD representation of VX in memory
      c.memory[c.i] = c.v[x] div 100
      c.memory[c.i + 1] = (c.v[x] div 10) mod 10
      c.memory[c.i + 2] = c.v[x] mod 10
    of 0x55: # Store V0 to VX in memory starting at address I
      for i in 0..x.uint64:
        c.memory[c.i + i.uint16] = c.v[i]
    of 0x65: # Load V0 to VX from memory starting at address I
      for i in 0..x.uint64:
        c.v[i] = c.memory[c.i + i.uint16]
    else: discard
  else:
    discard

proc updateInput(c: var Chip8) =
  # Map CHIP-8 4x4 keypad to standard keyboard layout
  # 1 2 3 C  ->  1 2 3 4
  # 4 5 6 D  ->  Q W E R
  # 7 8 9 E  ->  A S D F
  # A 0 B F  ->  Z X C V

  c.keypad[0x1] = IsKeyDown(KEY_ONE.int32)
  c.keypad[0x2] = IsKeyDown(KEY_TWO.int32)
  c.keypad[0x3] = IsKeyDown(KEY_THREE.int32)
  c.keypad[0xC] = IsKeyDown(KEY_FOUR.int32)

  c.keypad[0x4] = IsKeyDown(KEY_Q.int32)
  c.keypad[0x5] = IsKeyDown(KEY_W.int32)
  c.keypad[0x6] = IsKeyDown(KEY_E.int32)
  c.keypad[0xD] = IsKeyDown(KEY_R.int32)

  c.keypad[0x7] = IsKeyDown(KEY_A.int32)
  c.keypad[0x8] = IsKeyDown(KEY_S.int32)
  c.keypad[0x9] = IsKeyDown(KEY_D.int32)
  c.keypad[0xE] = IsKeyDown(KEY_F.int32)

  c.keypad[0xA] = IsKeyDown(KEY_Z.int32)
  c.keypad[0x0] = IsKeyDown(KEY_X.int32)
  c.keypad[0xB] = IsKeyDown(KEY_C.int32)
  c.keypad[0xF] = IsKeyDown(KEY_V.int32)

proc main() =
  randomize()

  var chip8: Chip8
  chip8.init()
  # chip8.loadROM("rom/PONG")
  # chip8.loadROM("rom/PONG2")
  # chip8.loadROM("rom/PONG3")
  # chip8.loadROM("rom/BRIX")
  # chip8.loadROM("rom/TETRIS")
  # chip8.loadROM("rom/number.ch8")
  # chip8.loadROM("rom/ibm.ch8")
  # chip8.loadROM("rom/PUZZLE")
  chip8.loadROM("rom/MAZE")

  InitWindow(ScreenWidth * Scale, ScreenHeight * Scale, "Nim CHIP-8 Emulator")
  SetTargetFPS(120)

  while not WindowShouldClose():
    updateInput(chip8)

    # Run multiple CPU cycles per frame
    for _ in 0..<7:
      chip8.emulateCycle()

    # Decrement 60Hz timers
    if chip8.delayTimer > 0: chip8.delayTimer -= 1
    if chip8.soundTimer > 0: chip8.soundTimer -= 1

    # Drawing
    BeginDrawing()
    ClearBackground(Black)

    if chip8.drawFlag:
      # Render 64x32 internal buffer using raylib
      for y in 0..<ScreenHeight:
        for x in 0..<ScreenWidth:
          if chip8.display[y * ScreenWidth + x]:
            DrawRectangle(
                (x * Scale).int32, (y * Scale).int32, 
                Scale, Scale, 
                WHITE
            )

    EndDrawing()

  CloseWindow()

main()
