;; extends
; Select the whole section under a `##` heading (heading + body, up to the next h2).
(section
  . (atx_heading
    . (atx_h2_marker) @_marker
  )
) @section.outer

(section
  . (setext_heading
    . (setext_h2_underline) @_marker
  )
) @section.outer
