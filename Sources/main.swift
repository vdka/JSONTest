import JSON

// PRE   0.0231777
// POST

/*

let bytes = loadFixture("large")

var total = 0.0

for _ in 0..<100 {
  total += try measure {
    _ = try JSON.Parser.parse(bytes)
  }
}

print("vdka/json took \(total / 100)s")

*/

func memdump<T>(_ input: T, nBytes: Int = MemoryLayout<T>.size) {

  var input = input

  withUnsafePointer(to: &input) { pointer in

    let bytePointer = unsafeBitCast(pointer, to: UnsafePointer<UInt8>.self)

    for i in 0 ..< MemoryLayout<T>.size(ofValue: pointer.pointee) {
      if i % 8 == 0 && i != 0 { print("\n", terminator: "") }

      let byte = bytePointer.advanced(by: i).pointee
      let hexByte = String(byte, radix: 16)

      // Pad the output to be 2 characters wide
      if hexByte.characters.count == 1 { print("0", terminator: "") }
      print(hexByte, terminator: " ")
    }
    print("")
  }
}

print("JSON is \(MemoryLayout<JSON>.size) bytes")

print("{'key': 5}")
memdump(["key": 5] as JSON)

print("[5, 2, 'value', true]")
memdump(true as JSON)

print("null")
memdump(JSON.null)

print("0xBADF00D")
memdump(0xBADF00D as JSON)
