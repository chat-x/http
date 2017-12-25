/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public enum MediaType: Equatable {
    case application(ApplicationSubtype)
    case audio(AudioSubtype)
    case image(ImageSubtype)
    case multipart(MultipartSubtype)
    case text(TextSubtype)
    case video(VideoSubtype)
    case any
}

public enum ApplicationSubtype {
    case json
    case javascript
    case formURLEncoded
    case stream
    case pdf
    case zip
    case gzip
    case xgzip
    case xml
    case xhtml
    case any
}

public enum AudioSubtype {
    case mp4
    case aac
    case mpeg
    case webm
    case vorbis
    case any
}

public enum ImageSubtype {
    case gif
    case jpeg
    case png
    case svg
    case tiff
    case webp
    case any
}

public enum MultipartSubtype {
    case formData
    case any
}

public enum TextSubtype {
    case css
    case csv
    case html
    case plain
    case php
    case xml
    case any
}

public enum VideoSubtype {
    case mpeg
    case mp4
    case ogg
    case quicktime
    case webm
    case any
}