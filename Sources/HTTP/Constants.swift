/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

struct Character {
    static let whitespace = UInt8(ascii: " ")
    static let cr = UInt8(ascii: "\r")
    static let lf = UInt8(ascii: "\n")
    static let colon = UInt8(ascii: ":")
    static let semicolon = UInt8(ascii: ";")
    static let comma = UInt8(ascii: ",")
    static let questionMark = UInt8(ascii: "?")
    static let slash = UInt8(ascii: "/")
    static let asterisk = UInt8(ascii: "*")
}

struct Constants {
    static let lineEnd = [Character.cr, Character.lf]
    static let minimumHeaderLength = ASCII("a:a\r\n").count
    static let minimumChunkLength = ASCII("0\r\n").count
}

let tokens: [Bool] = [
    /* nul   soh   stx    etx    eot    enq    ack    bel */
    false, false, false, false, false, false, false, false,
    /* bs    ht     nl    vt     np     cr     so     si  */
    false, false, false, false, false, false, false, false,
    /* dle   dc    dc     dc     dc     nak    syn    etb */
    false, false, false, false, false, false, false, false,
    /* can   em    sub    esc    fs     gs     rs     us  */
    false, false, false, false, false, false, false, false,
    /* sp    !      "      #      $      %      &      '  */
    false, true,  false, true,  true,  true,  true,  true,
    /* (     )      *      +      ,      -      .      /  */
    false, false, true,  true,  false, true,  true,  false,
    /* 0     1      2      3      4      5      6      7  */
    true,  true,  true,  true,  true,  true,  true,  true,
    /* 8     9      :      ;      <      =      >      ?  */
    true,  true,  false, false, false, false, false, false,
    /* @     A      B      C      D      E      F      G  */
    false, true,  true,  true,  true,  true,  true,  true,
    /* H     I      J      K      L      M      N      O  */
    true,  true,  true,  true,  true,  true,  true,  true,
    /* P     Q      R      S      T      U      V      W  */
    true,  true,  true,  true,  true,  true,  true,  true,
    /* X     Y      Z      [      \      ]      ^      _  */
    true,  true,  true,  false, false, false, true,  true,
    /* `     a      b      c      d      e      f      g  */
    true,  true,  true,  true,  true,  true,  true,  true,
    /* h     i      j      k      l      m      n      o  */
    true,  true,  true,  true,  true,  true,  true,  true,
    /* p     q      r      s      t      u      v      w  */
    true,  true,  true,  true,  true,  true,  true,  true,
    /* x     y      z      {      |      }      ~     del */
    true,  true,  true,  false, true,  false, true,  false ]
