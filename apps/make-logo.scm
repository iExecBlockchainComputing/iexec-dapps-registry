(define (make-logo color)
  ; Create an img and a layer
  (gimp-palette-set-background color)
  (let* (
      (width 500)
      (height 500)
      (image (car (gimp-image-new width height RGB)))
      (iexec-layer (car (gimp-layer-new image width height RGBA-IMAGE "iExec layer" 100 NORMAL)))
      (triangle-layer (car (gimp-layer-new image width height RGB "triangle layer" 100 NORMAL)))
    )
    ; The following is done for all scripts
    (gimp-image-undo-disable image)
    (gimp-image-add-layer image iexec-layer 0)
    (gimp-image-add-layer image triangle-layer 1)

    (gimp-drawable-fill triangle-layer BACKGROUND-FILL)

    (gimp-context-set-foreground '(255 255 255))
    (let* (
        (iexec-text (car (gimp-text-fontname image iexec-layer 130 290 "iExec" 0 1 100 0 "Trebuchet MS Bold")))
      )
    ; Anchor the selection
    (gimp-floating-sel-anchor iexec-text)

    (gimp-context-set-foreground '(254 229 0))
      (let* (
          (triangle-text (car (gimp-text-fontname image triangle-layer 190 50 "▶" 0 1 190 0 "Sans")))
        )
        ; Anchor the selection
        (gimp-floating-sel-anchor triangle-text)

        ; Call a plugin to blur the iExec logo
        (plug-in-gauss-rle 1 image triangle-layer 50 1 1)

        ; merge layers
        (gimp-image-merge-down image iexec-layer 0)

        ; show in gimp
        ; (gimp-display-new image)
        (gimp-image-undo-enable image)

        (let* (
           (layer (car (gimp-image-get-active-layer image)))
          )
          ; Save image
          (gimp-file-save RUN-NONINTERACTIVE image layer "iExec-logo.png" "iExec-logo.png")
        )
      )
    )
  )
 )
