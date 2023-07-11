(list 
  ; (channel
  ;   (name 'lisux)
  ;   (url "https://gitee.com/liszt21/lisux.git")
  ;   (introduction
  ;    (make-channel-introduction
  ;     "d4ad130614963334f3f94a8b5f6ad7d1ba4eac3e"
  ;     (openpgp-fingerprint
  ;      "ABFC 5483 F3F7 1C39 922E  2E42 0EEA FA02 DA3C 7513"))))
  (channel
    (name 'nonguix)
    (url "https://gitee.com/liszt21/nonguix.git")
    ;; Enable signature verification:
    (introduction
     (make-channel-introduction
      "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
      (openpgp-fingerprint
       "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
  (channel
       (inherit (car %default-channels))
       (url "https://git.sjtu.edu.cn/sjtug/guix/")))

