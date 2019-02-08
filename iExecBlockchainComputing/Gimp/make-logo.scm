(define (make-logo color font-size text)
  ; (make-logo '(0 0 0) 100 \"iExec\")
  (gimp-palette-set-background color)
  (let* (
      (width 10)
      (height 10)
      (triangle-size (* font-size 1.5))
      (image (car (gimp-image-new width height RGB)))
    )
    (gimp-image-undo-disable image)
    (gimp-context-set-foreground '(255 255 255))

    (let* (
        (iexec-text-layer (car (gimp-text-fontname image -1 0 0 text 0 1 font-size PIXELS "Trebuchet MS Bold")))
        (text-layer-width (car (gimp-drawable-width iexec-text-layer)))
        (text-layer-height (car (gimp-drawable-height iexec-text-layer)))
        (image-size (* text-layer-width 2))
      )
      (gimp-image-resize image image-size image-size 0 0)
      (gimp-context-set-foreground '(254 229 0))

      (let* (
          (triangle-text-layer (car (gimp-text-fontname image -1 0 0 "▶" 0 1 triangle-size 0 "Sans")))
          (triangle-layer-width (car (gimp-drawable-width triangle-text-layer)))
          (triangle-layer-height (car (gimp-drawable-height triangle-text-layer)))
          (background-layer (car (gimp-layer-new image image-size image-size RGB "iExec layer" 100 NORMAL)))
        )
        (gimp-image-add-layer image background-layer 2)
        (gimp-drawable-fill background-layer BACKGROUND-FILL)

        (gimp-layer-translate
          iexec-text-layer
          (- (/ image-size 2) (/ text-layer-width 2))
          (+ (/ image-size 2) (* text-layer-height 0))
        )
        (gimp-layer-translate
          triangle-text-layer
          (- (/ image-size 2) (/ triangle-layer-width 2))
          (- (/ image-size 2) (* triangle-layer-height 1))
        )

        ; Call a plugin to blur the pikachu triangle
        (plug-in-gauss-rle 1 image triangle-text-layer 50 1 1)

        ; merge layers
        (gimp-image-merge-visible-layers image EXPAND-AS-NECESSARY)

        ; show in gimp
        ; (gimp-display-new image)
        (gimp-image-undo-enable image)

        (let* (
           (layer (car (gimp-image-get-active-layer image)))
           (filename (string-append text "-logo.png"))
          )
          ; Save image
          (gimp-file-save RUN-NONINTERACTIVE image layer filename filename)
        )
      )
    )
  )
 )
